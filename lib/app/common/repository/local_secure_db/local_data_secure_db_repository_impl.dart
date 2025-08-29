// ignore_for_file: lines_longer_than_80_chars

import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';

import 'package:perubeca/app/database/local_auth_db.dart';

class LocalDataSecureDbRepositoryImpl extends ILocalDataSecureDbRepository {
  LocalDataSecureDbRepositoryImpl();

  final LocalAuthDB service = getItApp.get<LocalAuthDB>();

  @override
  Future<void> setAuthToken(String token) => service.setAuthToken(token);

  @override
  Future<String> getAuthToken() => service.getAuthToken();

  //profile
  @override
  Future<void> setAuthTokenProfile(String token) => service.setAuthTokenProfile(token);

  @override
  Future<String> getAuthTokenProfile() => service.getAuthTokenProfile();

  @override
  Future<String> getPushToken() => service.getPushToken();
  @override
  Future<void> setPushToken(String token) => service.setPushToken(token);

  @override
  Future<String> getIsLocal() => service.getIsLocal();
  @override
  Future<void> setIsLocal(String token) => service.setIsLocal(token);
  
  @override
  Future<void> deleteAllData() => service.deleteAllData();
}
