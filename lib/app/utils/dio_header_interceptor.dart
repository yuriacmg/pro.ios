// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/repository/auth/i_auth_repository.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';

class DioHeaderInterceptor extends Interceptor {
  final dio = getItApp.get<Dio>();
  final ILocalDataSecureDbRepository localSecureDbRepository = getItApp.get<ILocalDataSecureDbRepository>();
  final IAuthRepository authRepository = getItApp.get<IAuthRepository>();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await localSecureDbRepository.getAuthToken(); //obteniendo el token
    options.headers['Authorization'] = 'bearer $token';
    options.headers['Content-Type'] = 'application/json';
    //options.headers['Access-Control-Allow-Headers'] = '*';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null && err.response?.statusCode == 401) {
      final authResponse = await authRepository.getTokenAutorization();
      final token = authResponse.data as String;
      await localSecureDbRepository.setAuthToken(token);

      final response = await dio.fetch(err.requestOptions);

      return handler.resolve(response);
    }

    return handler.reject(err);
  }
}
