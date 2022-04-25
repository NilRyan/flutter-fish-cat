
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _keyToken = 'access_token';

  static Future setToken(String username) async =>
      await _storage.write(key: _keyToken, value: username);

  static Future<String?> getToken() async =>
      await _storage.read(key: _keyToken);

}