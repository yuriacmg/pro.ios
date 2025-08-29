part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class GetNotificationDataLocalEvent extends NotificationEvent {
  @override
  List<Object> get props => [];
}

class GetMoreNotificationsEvent extends NotificationEvent {
   @override
  List<Object> get props => [];
}

class MarkAllNotificationsAsReadEvent extends NotificationEvent {
  @override
  List<Object> get props => [];
}
