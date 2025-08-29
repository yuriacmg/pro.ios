// ignore_for_file: lines_longer_than_80_chars, file_names, cascade_invocations

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:perubeca/app/common/cubit/notification_status_cubit.dart';
import 'package:perubeca/app/common/repository/auth/auth_repository_impl.dart';
import 'package:perubeca/app/common/repository/auth/i_auth_repository.dart';
import 'package:perubeca/app/common/repository/local_json/i_local_data_json_repository.dart';
import 'package:perubeca/app/common/repository/local_json/local_data_json_repository_impl.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/common/repository/local_secure_db/local_data_secure_db_repository_impl.dart';
import 'package:perubeca/app/common/repository/util/i_util_repository.dart';
import 'package:perubeca/app/common/repository/util/util_repository_impl.dart';
import 'package:perubeca/app/common/service/auth_service.dart';
import 'package:perubeca/app/common/service/local_data_json_service.dart';
import 'package:perubeca/app/common/service/util_service.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/app/database/local_auth_db.dart';
import 'package:perubeca/app/modules/login/repository/i_login_repository.dart';
import 'package:perubeca/app/modules/login/repository/login_repository_impl.dart';
import 'package:perubeca/app/modules/login/service/login_service.dart';
import 'package:perubeca/app/modules/notification/bloc/notification-update-api/notification_update_api_bloc.dart';
import 'package:perubeca/app/modules/notification/bloc/notification_bloc.dart';
import 'package:perubeca/app/modules/notification/repository/i_notification_repository.dart';
import 'package:perubeca/app/modules/notification/repository/notification_repository_impl.dart';
import 'package:perubeca/app/modules/notification/service/notification_service.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';
import 'package:perubeca/app/modules/scholarship/repository/scholarship_repository_impl.dart';
import 'package:perubeca/app/modules/scholarship/service/scholarship_service.dart';
import 'package:perubeca/app/utils/dio_header_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DependencyInjection {
  void setup(GetIt getItApp) {

    final dio = Dio(
      BaseOptions(
        baseUrl: InitFlavorConfig.urlApp,
        contentType: 'application/json',
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        // validateStatus: (status) => true,
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }

    getItApp.registerLazySingleton(() => dio);

    // repositories
    getItApp.registerLazySingleton<ILocalDataJsonRepository>(LocalDataJsonRepositoryImpl.new);
    getItApp.registerLazySingleton<ILocalDataSecureDbRepository>(LocalDataSecureDbRepositoryImpl.new);
    getItApp.registerLazySingleton<IAuthRepository>(AuthRepositoryImpl.new);
    getItApp.registerLazySingleton<IScholarshipRepository>(ScholarshipRepositoryImpl.new);
    getItApp.registerLazySingleton<IloginRepository>(LoginRepositoryImpl.new);
    getItApp.registerLazySingleton<IUtilRepository>(UtilRepositoryImpl.new);
    getItApp.registerLazySingleton<INotificationRepository>(NotificationRepositoryImpl.new);

    // services
    getItApp.registerLazySingleton(LocalDataJsonService.new);
    getItApp.registerLazySingleton(LocalAuthDB.new);
    getItApp.registerLazySingleton(UtilService.new);
    getItApp.registerLazySingleton(AuthService.new);
    getItApp.registerLazySingleton(ScholarShipService.new);
    getItApp.registerLazySingleton(LoginService.new);
    getItApp.registerLazySingleton(NotificationService.new);


    //notifications
    getItApp.registerSingleton<NotificationStatusCubit>(NotificationStatusCubit());
    getItApp.registerSingleton<NotificationUpdateApiBloc>(NotificationUpdateApiBloc());
    getItApp.registerSingleton<NotificationBloc>(NotificationBloc());

    dio.interceptors.add(DioHeaderInterceptor());
  }
}
