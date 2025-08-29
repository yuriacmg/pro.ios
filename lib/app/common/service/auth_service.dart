// ignore_for_file: inference_failure_on_function_invocation, avoid_dynamic_calls, lines_longer_than_80_chars

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class AuthService {
  Future<APIResponseModel> getTokenAutorization() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: InitFlavorConfig.urlAuth,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );

    dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseData: false,
        ),
      ),
    );

    final body = {
      'grant_type': InitFlavorConfig.grantType,
      'client_id': InitFlavorConfig.clientId,
      'client_secret': InitFlavorConfig.clientSecret,
    };

    final res = APIResponseModel(false, 999, null, '');
    try {
      final response = await dio.post('', data: body);

      if (response.statusCode == 200) {
        res
          ..status = true
          ..statusCode = int.parse(response.statusCode!.toString())
          ..data = response.data['access_token'];
      } else {
        res
          ..status = false
          ..statusCode = int.parse(response.statusCode!.toString())
          ..data = ErrorResponseModel.fromJson(
            response.data as Map<String, dynamic>,
          );
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          res
            ..status = false
            ..statusCode = 950 // codigo que no hay internet
            ..data = getErrorInternet();
        } else {
          res
            ..status = false
            ..statusCode = e.response == null ? 500 : int.parse(e.response!.statusCode.toString())
            ..data = getErrorInit();
        }
      }
    }

    return res;
  }
}
