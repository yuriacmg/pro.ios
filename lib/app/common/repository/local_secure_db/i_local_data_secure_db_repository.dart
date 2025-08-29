abstract class ILocalDataSecureDbRepository {
  Future<void> setAuthToken(String token);
  Future<String> getAuthToken();
  //profile
  Future<void> setAuthTokenProfile(String token);
  Future<String> getAuthTokenProfile();
  //recovery
  //Future<void> setAuthTokenRecovery(String token);
  //Future<String> getAuthTokenRecovery();

  Future<void> setPushToken(String token);
  Future<String> getPushToken();
  Future<void>   setIsLocal(String token);
  Future<String> getIsLocal();
  Future<void>   deleteAllData();
}
