// ignore_for_file: inference_failure_on_function_invocation, lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/modules/notification/model/notification_response_model.dart';
import 'package:perubeca/app/utils/methods.dart';

class NotificationService {
  final dio = getItApp.get<Dio>();

  Future<APIResponseModel> getNotifications(String idPush) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Notificacion/postObtener', data: {'v_id_push_notificacion': idPush});
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = NotificationResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

}
