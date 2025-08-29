// ignore_for_file: lines_longer_than_80_chars, sort_constructors_first

part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitialState extends NotificationState {
  @override
  List<Object> get props => [];
}


class NotificationLoadLocalCompleteState extends NotificationState {
  final List<NotificationEntity> newNotifications;
  final List<NotificationEntity> todayNotifications;
  final List<NotificationEntity> earlierNotifications;
  final bool hasReachedMaxNew;
  final bool hasReachedMaxToday;
  final bool hasReachedMaxEarlier;

  const NotificationLoadLocalCompleteState({
    required this.newNotifications,
    required this.todayNotifications,
    required this.earlierNotifications,
    required this.hasReachedMaxNew,
    required this.hasReachedMaxToday,
    required this.hasReachedMaxEarlier,
  });

  NotificationLoadLocalCompleteState copyWith({
    List<NotificationEntity>? newNotifications,
    List<NotificationEntity>? todayNotifications,
    List<NotificationEntity>? earlierNotifications,
    bool? hasReachedMaxNew,
    bool? hasReachedMaxToday,
    bool? hasReachedMaxEarlier,
  }) {
    return NotificationLoadLocalCompleteState(
      newNotifications: newNotifications ?? this.newNotifications,
      todayNotifications: todayNotifications ?? this.todayNotifications,
      earlierNotifications: earlierNotifications ?? this.earlierNotifications,
      hasReachedMaxNew: hasReachedMaxNew ?? this.hasReachedMaxNew,
      hasReachedMaxToday: hasReachedMaxToday ?? this.hasReachedMaxToday,
      hasReachedMaxEarlier: hasReachedMaxEarlier ?? this.hasReachedMaxEarlier,
    );
  }

  @override
  List<Object> get props => [newNotifications, todayNotifications, earlierNotifications, hasReachedMaxNew, hasReachedMaxToday, hasReachedMaxEarlier];

}
