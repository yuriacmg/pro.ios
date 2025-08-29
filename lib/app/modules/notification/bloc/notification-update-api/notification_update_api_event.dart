// notification_update_api_event.dart

part of 'notification_update_api_bloc.dart';

abstract class NotificationUpdateApiEvent extends Equatable {
  const NotificationUpdateApiEvent();
}

class LoadNotificationsEvent extends NotificationUpdateApiEvent {

  const LoadNotificationsEvent();

  @override
  List<Object> get props => [];
}
