// ignore_for_file: inference_failure_on_instance_creation, lines_longer_than_80_chars, use_build_context_synchronously, cascade_invocations

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/cubit/notification_status_cubit.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/common/service/util_service.dart';
import 'package:perubeca/app/database/entities/notification_entity.dart';
import 'package:perubeca/app/modules/notification/bloc/notification-update-api/notification_update_api_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Clave global para ScaffoldMessenger
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  // llamada de bloc de carga de notificaciones y guardado en local

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
   final sendPort = IsolateNameServer.lookupPortByName('main_port');
    if (sendPort != null) {
      sendPort.send({
        'title': message.notification?.title ?? 'Sin título',
        'body': message.notification?.body ?? 'Sin descripción',
      });
    } else {
      // Guarda la notificación en SharedPreferences
      //final prefs = await SharedPreferences.getInstance();
      //final storedNotifications = prefs.getStringList('notifications') ?? [];
      final newNotification = {
        'title': message.notification?.title ?? 'Sin título',
        'body': message.notification?.body ?? 'Sin descripción',
        'date': DateTime.now().toIso8601String(),
      };
      //storedNotifications.add(jsonEncode(newNotification));
      //await prefs.setStringList('notifications', storedNotifications);
     debugPrint(
          'Notificación guardada en SharedPreferences: ${newNotification['title']}',);
    }
  } catch (e) {
    debugPrint('Error en el handler de segundo plano: $e');
  }
}

void setupIsolateCommunication() {
  final receivePort = ReceivePort();
  IsolateNameServer.registerPortWithName(receivePort.sendPort, 'main_port');

  receivePort.listen((data) async {
    if (data is Map<String, dynamic>) {
      try {
        final box = await Hive.openBox<NotificationEntity>('notificationBox');
        final total = box.values.length;

        final newNotification = NotificationEntity(
          idNotification: total + 1,
          title: data['title']! as String,
          description: data['body']! as String,
          registerDate: DateTime.now(),
        );
        getItApp<NotificationUpdateApiBloc>().add(const LoadNotificationsEvent());
        getItApp<NotificationStatusCubit>().markAsNewNotification();
        await box.add(newNotification);
        debugPrint('Notificación guardada en Hive.');
      } catch (e) {
        //final prefs = await SharedPreferences.getInstance();
        //final storedNotifications = prefs.getStringList('notifications') ?? [];

        final newNotification = {
          'title': data['title']! as String,
          'body': data['body']! as String,
          'date': DateTime.now().toIso8601String(),
        };

        //storedNotifications.add(jsonEncode(newNotification));
        //await prefs.setStringList('notifications', storedNotifications);

        debugPrint(
            'Notificación guardada en SharedPreferences: ${newNotification['title']}',);
      }
    }
  });
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;

class PushNotificationProvider {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final localSecureDbRepository = getItApp.get<ILocalDataSecureDbRepository>();

  Future<void> initNotifications(BuildContext context) async {
    final settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('Permisos de notificación otorgados.');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('Permisos provisionales otorgados.');
    } else {
      debugPrint('Permisos de notificación denegados.');
    }

    // Obtener el token de Firebase coon reintento
    try {
      final token =
          await fetchTokenWithRetry(onErrorCallback: callSaveTokenPush);
      if (token != null && token.isNotEmpty) {
        if(Platform.isIOS){
        debugPrint('TOKEN DE DISPOSITIVO: $token');
          ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Token Obtenido')));
        await localSecureDbRepository.setPushToken(token);
        }
      } else {
        if(Platform.isIOS){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'No se pudo obtener el token después de varios intentos.',),),);
          debugPrint('No se pudo obtener el token después de varios intentos.');
        }
      }
    } catch (e) {
      if(Platform.isIOS){
           ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener el token de firebase $e')),);
        debugPrint('Error inesperado al obtener el token de Firebase: $e');
        }
    }
    setupIsolateCommunication();

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler,);
    } catch (e) {
      developer.log(e.toString());
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (Platform.isIOS) {
      const initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const darwinInitializationSettings = DarwinInitializationSettings(

          //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
          );

      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: darwinInitializationSettings,
      );

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;
      if (notification != null) {
        
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              //channelDescription: channel.description,
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
      getItApp<NotificationUpdateApiBloc>().add(const LoadNotificationsEvent());
      //getItApp<NotificationBloc>().add(GetNotificationDataLocalEvent());
      getItApp<NotificationStatusCubit>().markAsNewNotification();
    });
  }

  Future<String?> fetchTokenWithRetry({
    required Future<void> Function() onErrorCallback,
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 2),
  }) async {
    var attempt = 0;
    String? token;
    var hadError = false;

    while (attempt <= maxRetries) {
      try {
        token = await FirebaseMessaging.instance.getToken();
        if (token != null && token.isNotEmpty) {
          // Si se obtiene un token válido, retorna el token
          //if (hadError) {
          // Si hubo algún error previo, llama al callback
          await localSecureDbRepository.setPushToken(token);
          await onErrorCallback();
          //}
          return token;
        }
      } catch (e) {
        hadError = true; // Marca que hubo un error
        debugPrint('Error al obtener el token (Intento ${attempt + 1}): $e');
      }

      if (attempt < maxRetries) {
        debugPrint(
            'Reintentando obtener el token en ${delay.inSeconds} segundos...',);
        await Future.delayed(delay); // Espera antes del próximo intento
      }
      attempt++;
    }

    return null; // Si no se obtiene un token, retorna null
  }

  Future<void> callSaveTokenPush() async {
    final utilService = getItApp.get<UtilService>();
    final send = await utilService.getDeviceInfo();
    final ptoke = await localSecureDbRepository.getPushToken();
    send.tokenPushNoti =
        ptoke.isEmpty ? 'EL TOKEN GENERADO DE FIREBASE NO EXISTE 2' : ptoke;
    await utilService.getVersionApp(send);
  }

  Future<void> processStoredNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final storedNotifications = prefs.getStringList('notifications');

    if (storedNotifications != null && storedNotifications.isNotEmpty) {
      final box = await Hive.openBox<NotificationEntity>('notificationBox');

      for (final jsonString in storedNotifications) {
        final notificationData = jsonDecode(jsonString) as Map<String, dynamic>;

        final newNotification = NotificationEntity(
          idNotification: box.values.length + 1,
          title: notificationData['title'] as String,
          description: notificationData['body'] as String,
          registerDate: DateTime.parse(notificationData['date'] as String),
        );

        await box.add(newNotification);
        debugPrint('Notificación transferida a Hive: ${newNotification.title}');
      }
      await prefs.remove('notifications');
    }
  }
}
