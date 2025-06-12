import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _storage = FlutterSecureStorage();
  static const _tokenKey = 'token';
  static const _email = 'email';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<void> saveEmail(String email) async {
    await _storage.write(key: _email, value: email);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<void> clearEmail() async {
    await _storage.delete(key: _email);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
