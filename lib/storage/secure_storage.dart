
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();
  static final _token = _storage.write(key: _keyToken, value: '');
  static const _keyToken = 'access_token';

  static Future setToken(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future<String?> getToken() async =>
      await _storage.read(key: _keyToken);


  static Future<void> deleteToken() async =>
      await _storage.write(key: _keyToken, value: '');

}