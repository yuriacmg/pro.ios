// notification_update_api_bloc.dart

// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/service/util_service.dart';
import 'package:perubeca/app/database/entities/notification_entity.dart';
import 'package:perubeca/app/modules/notification/model/notification_response_model.dart';
import 'package:perubeca/app/modules/notification/repository/i_notification_repository.dart';

part 'notification_update_api_event.dart';
part 'notification_update_api_state.dart';

class NotificationUpdateApiBloc
    extends Bloc<NotificationUpdateApiEvent, NotificationUpdateApiState> {

  NotificationUpdateApiBloc() : super(NotificationUpdateApiInitialState()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
  }

  final INotificationRepository _repository = getItApp.get<INotificationRepository>();
  final UtilService _utilService = getItApp.get<UtilService>();

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationUpdateApiState> emitter,
  ) async {
    try {
      emitter(NotificationUpdateApiLoadingState());

      final box = await _getNotificationBox();
      final util = await _utilService.getDeviceInfo();
      final response = await Future.delayed(
          const Duration(milliseconds: 200), 
          () async {
            return _repository.getNotifications(util.idUnicoPushNoti);
          },
        );
      final notifications = (response.data as NotificationResponseModel).value!.notificaciones ?? [];

      // Eliminar notificaciones locales que no tengan id
      await _deleteLocalNotificationsWithNoId(box);

      // Obtener notificaciones locales y API
      final localNotifications = box.values.toList();
      final localIds = localNotifications.map((e) => e.idApi).toSet();
      final apiIds = notifications.map((e) => e.id).toSet();

      // Obtener ids únicos de la API
      final uniqueApiIds = apiIds.difference(localIds).toList();

      if(uniqueApiIds.isNotEmpty){
        // Filtrar las nuevas notificaciones
        final newNotifications = notifications.where((e) => uniqueApiIds.contains(e.id));
        // Guardar las nuevas notificaciones en la base de datos local
        await _saveNotificationsToLocalDatabase(newNotifications, box);
      }

      emitter(NotificationUpdateApiLoadedState());
    } catch (e) {
      emitter(NotificationUpdateApiErrorState(error: e.toString()));
    }
  }

  Future<Box<NotificationEntity>> _getNotificationBox() async {
    if (!Hive.isBoxOpen('notificationBox')) {
      return Hive.openBox<NotificationEntity>('notificationBox');
    }
    return Hive.box<NotificationEntity>('notificationBox');
  }

  Future<void> _deleteLocalNotificationsWithNoId(Box<NotificationEntity> box) async {
    for (final entry in box.toMap().entries) {
        final notification = entry.value;
        if(notification.idApi == 0 || notification.idApi == null){
          await box.delete(entry.key);
        }
      }
  }

  Future<void> _saveNotificationsToLocalDatabase(Iterable<Notification> newNotifications, Box<NotificationEntity> box) async {
    for (final n in newNotifications) {
      final newNotification = NotificationEntity(
        idNotification: box.values.length + 1,
        title: n.titulo ?? '',
        description: n.contenido ?? '',
        registerDate: DateTime.parse(n.fecha ?? '1970-01-01'),
        idApi: n.id,
      );
      
    await box.add(newNotification);
    }

  }
}
