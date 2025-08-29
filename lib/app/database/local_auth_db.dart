import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class LocalAuthDB {
  static final _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
  );

  Future<void> setAuthToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  Future<String> getAuthToken() async {
    final token = await _storage.read(key: 'authToken');
    return token ?? '';
  }

  //pushnotification
  Future<void> setPushToken(String token) async {
    await _storage.write(key: 'pushToken', value: token);
  }

  Future<String> getPushToken() async {
    final token = await _storage.read(key: 'pushToken');
    return token ?? '';
  }

  //pushnotification
  Future<void> setIsLocal(String token) async {
    await _storage.write(key: 'isLocal', value: token);
  }

  Future<String> getIsLocal() async {
    final token = await _storage.read(key: 'isLocal');
    return token ?? '';
  }


  //profile
  Future<void> setAuthTokenProfile(String token) async {
    await _storage.write(key: 'authTokenProfile', value: token);
  }

  Future<String> getAuthTokenProfile() async {
    final token = await _storage.read(key: 'authTokenProfile');
    return token ?? '';
  }
  //recovery account
  Future<void> setAuthTokenRecovery(String token) async {
    await _storage.write(key: 'authTokenRecovery', value: token);
  }

  Future<String> getAuthTokenRecovery() async {
    final token = await _storage.read(key: 'authTokenRecovery');
    return token ?? '';
  }

  Future<void> deleteAllData() async {
    //await _storage.deleteAll();
  final allData = await _storage.readAll();
  for (final key in allData.keys) {
    if (key != 'pushToken') {
      await _storage.delete(key: key);
    }
  }
  }
}
