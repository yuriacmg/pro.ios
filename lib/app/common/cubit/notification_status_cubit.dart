import 'package:bloc/bloc.dart';

class NotificationStatusCubit extends Cubit<bool> {
  NotificationStatusCubit() : super(false); 

  void markAsNewNotification() => emit(true);
  void clearNotificationStatus() => emit(false);
}
