// ignore_for_file: lines_longer_than_80_chars, cascade_invocations

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/notification_entity.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  NotificationBloc() : super(NotificationInitialState()) {
    on<GetNotificationDataLocalEvent>(_onGetLocalData);
    on<GetMoreNotificationsEvent>(_onGetMoreNotifications);
    on<MarkAllNotificationsAsReadEvent>(_onMarkAllNotificationsAsRead);
  }
  //static const int _maxNotifications = 100;
  //static const int _minNotifications = 50;
  static const int _pageSize = 10;

  /// Carga y sincroniza las notificaciones con los datos almacenados en SharedPreferences.
 Future<void> _onGetLocalData(
    GetNotificationDataLocalEvent event, Emitter<NotificationState> emitter,) async {
  emitter(NotificationInitialState());

  final notificationBox = await _getNotificationBox();
  var notifications = notificationBox.values.toList();

  notifications = notifications.where((notification) {
    return notification.title != 'Sin título';
  }).toList();

  // Ordenar notificaciones
  notifications.sort((a, b) {
    if (a.isOpen == b.isOpen) {
      return b.registerDate.compareTo(a.registerDate);
    }
    return a.isOpen ? 1 : -1; 
  });

  // Dividir en categorías
  final now = DateTime.now();
  final categorizedNewNotifications = <NotificationEntity>[]; // Nuevas
  final categorizedTodayNotifications = <NotificationEntity>[]; // Hoy
  final categorizedEarlierNotifications = <NotificationEntity>[]; // Más antiguas

  for (final notification in notifications) {
    final duration = now.difference(notification.registerDate);
    if (!notification.isOpen) {
      categorizedNewNotifications.add(notification);
    } else if (duration.inDays == 0) {
      categorizedTodayNotifications.add(notification);
    } else {
      categorizedEarlierNotifications.add(notification);
    }
  }

  final initialNewNotifications = categorizedNewNotifications.take(_pageSize).toList();
  final initialTodayNotifications = categorizedTodayNotifications.take(_pageSize).toList();
  final initialEarlierNotifications = categorizedEarlierNotifications.take(_pageSize).toList();

  emitter(NotificationLoadLocalCompleteState(
    newNotifications: initialNewNotifications,
    todayNotifications: initialTodayNotifications,
    earlierNotifications: initialEarlierNotifications,
    hasReachedMaxNew: initialNewNotifications.length >= categorizedNewNotifications.length,
    hasReachedMaxToday: initialTodayNotifications.length >= categorizedTodayNotifications.length,
    hasReachedMaxEarlier: initialEarlierNotifications.length >= categorizedEarlierNotifications.length,
  ),);
}

  /// Carga más notificaciones desde Hive, asegurando que no haya duplicados.
  Future<void> _onGetMoreNotifications(
      GetMoreNotificationsEvent event, Emitter<NotificationState> emitter,) async {
    if (state is NotificationLoadLocalCompleteState) {
      final currentState = state as NotificationLoadLocalCompleteState;

      final notificationBox = await _getNotificationBox();
      var notifications = notificationBox.values.toList();

      notifications = notifications.where((notification) {
        return notification.title != 'Sin título';
      }).toList();

      // Eliminar duplicados
      final uniqueNotifications = <int, NotificationEntity>{};
      for (final notification in notifications) {
        uniqueNotifications[notification.idApi!] = notification;
      }

      notifications = uniqueNotifications.values.toList();

      // Ordenar notificaciones
      notifications.sort((a, b) {
        if (a.isOpen == b.isOpen) {
          return b.registerDate.compareTo(a.registerDate);
        }
        return a.isOpen ? 1 : -1; // Priorizar nuevas (isOpen = false)
      });

      final now = DateTime.now();
      final newNotifications = <NotificationEntity>[];
      final todayNotifications = <NotificationEntity>[];
      final earlierNotifications = <NotificationEntity>[];

      for (final notification in notifications) {
        final duration = now.difference(notification.registerDate);
        if (!notification.isOpen) {
          newNotifications.add(notification);
        } else if (duration.inDays == 0) {
          todayNotifications.add(notification);
        } else {
          earlierNotifications.add(notification);
        }
      }

      final currentNewLength = currentState.newNotifications.length;
      final currentTodayLength = currentState.todayNotifications.length;
      final currentEarlierLength = currentState.earlierNotifications.length;

      final additionalNewNotifications =
          newNotifications.skip(currentNewLength).take(_pageSize).toList();
      final additionalTodayNotifications =
          todayNotifications.skip(currentTodayLength).take(_pageSize).toList();
      final additionalEarlierNotifications =
          earlierNotifications.skip(currentEarlierLength).take(_pageSize).toList();

      emitter(NotificationLoadLocalCompleteState(
        newNotifications: currentState.newNotifications + additionalNewNotifications,
        todayNotifications: currentState.todayNotifications + additionalTodayNotifications,
        earlierNotifications: currentState.earlierNotifications + additionalEarlierNotifications,
        hasReachedMaxNew: currentNewLength + additionalNewNotifications.length >= newNotifications.length,
        hasReachedMaxToday: currentTodayLength + additionalTodayNotifications.length >= todayNotifications.length,
        hasReachedMaxEarlier: currentEarlierLength + additionalEarlierNotifications.length >= earlierNotifications.length,
      ),);
    }
  }

  /// Marca todas las notificaciones como leídas y guarda los IDs en SharedPreferences.
Future<void> _onMarkAllNotificationsAsRead(
    MarkAllNotificationsAsReadEvent event, Emitter<NotificationState> emitter,) async {
  final notificationBox = await _getNotificationBox();

  for (final entry in notificationBox.toMap().entries) {
    final notification = entry.value;
    notification.isOpen = true;
    await notificationBox.put(entry.key, notification);
  }

  // Recargar notificaciones
  add(GetNotificationDataLocalEvent());
}

  /// Obtiene la caja de Hive para las notificaciones.
  Future<Box<NotificationEntity>> _getNotificationBox() async {
    if (!Hive.isBoxOpen('notificationBox')) {
      return Hive.openBox<NotificationEntity>('notificationBox');
    }
    return Hive.box<NotificationEntity>('notificationBox');
  }
}
