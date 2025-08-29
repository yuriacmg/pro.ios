import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/modules/notification/repository/i_notification_repository.dart';
import 'package:perubeca/app/modules/notification/service/notification_service.dart';

class NotificationRepositoryImpl extends INotificationRepository{
  final service = getItApp.get<NotificationService>();

  @override
  Future<APIResponseModel> getNotifications(String idPush) {
    return service.getNotifications(idPush);
  }
}
