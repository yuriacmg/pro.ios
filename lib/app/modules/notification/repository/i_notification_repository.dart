// ignore_for_file: one_member_abstracts

import 'package:perubeca/app/common/model/api_response_model.dart';

abstract class INotificationRepository {
  Future<APIResponseModel> getNotifications(String idPush);
}
