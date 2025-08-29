// ignore_for_file: cascade_invocations, lines_longer_than_80_chars, directives_ordering, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/cubit/notification_status_cubit.dart';
import 'package:perubeca/app/common/navigation_app/navigation_page.dart';
import 'package:perubeca/app/common/provider/push_notification_provider.dart';
import 'package:perubeca/app/database/entities/notification_entity.dart';
import 'package:perubeca/app/modules/notification/bloc/notification-update-api/notification_update_api_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      iniNotification();
      WidgetsBinding.instance.addObserver(this);
      getItApp<NotificationUpdateApiBloc>().add(const LoadNotificationsEvent());
    }
  }

  Future<void> iniNotification() async {
    final pushProvider = PushNotificationProvider();
    await pushProvider.initNotifications(context);
    await pushProvider.processStoredNotifications();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getItApp<NotificationUpdateApiBloc>().add(const LoadNotificationsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationUpdateApiBloc, NotificationUpdateApiState>(
      listener: (context, state) async{
        if(state is NotificationUpdateApiLoadingState){
        }

        if(state is NotificationUpdateApiLoadedState){
              // Abrir la caja de Hive si no está abierta
          final box = Hive.isBoxOpen('notificationBox')
              ? Hive.box<NotificationEntity>('notificationBox')
              : await Hive.openBox<NotificationEntity>('notificationBox');

          //final notifications = box.values.toList();
          // Obtener las notificaciones y filtrar las no leídas
          final unreadNotifications = box.values
              .where((notification) => notification.isOpen != true)
              .toList();

          // Determinar el estado de las notificaciones
          if (unreadNotifications.isNotEmpty) {
            getItApp<NotificationStatusCubit>().markAsNewNotification();
          }
        }

        if(state is NotificationUpdateApiLoadedState){

        }
      },
      child: NavigationPage(),
    );
  }
}
