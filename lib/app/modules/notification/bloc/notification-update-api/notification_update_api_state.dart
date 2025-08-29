// notification_update_api_state.dart

part of 'notification_update_api_bloc.dart';

abstract class NotificationUpdateApiState extends Equatable {
  const NotificationUpdateApiState();
  
  @override
  List<Object> get props => [];
}

class NotificationUpdateApiInitialState extends NotificationUpdateApiState {}

class NotificationUpdateApiLoadingState extends NotificationUpdateApiState {}

class NotificationUpdateApiLoadedState extends NotificationUpdateApiState {
  @override
  List<Object> get props => [];
}

class NotificationUpdateApiErrorState extends NotificationUpdateApiState {

  const NotificationUpdateApiErrorState({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
