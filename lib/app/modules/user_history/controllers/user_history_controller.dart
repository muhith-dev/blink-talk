import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserHistoryController extends GetxController {
  final _storage = const FlutterSecureStorage();
  final String _key = 'login_history';

  Future<void> printRawStorageData() async {
    final allKeys = await _storage.readAll();
    allKeys.forEach((key, value) {
      print('KEY: $key');
      print('VALUE: $value');
    });
  }

  Future<void> saveLoginHistory(String email, String method) async {
    String? existing = await _storage.read(key: 'login_history');

    List<Map<String, String>> history = [];

    if (existing != null) {
      history = List<Map<String, String>>.from(jsonDecode(existing));
    }

    history.add({
      'email': email,
      'method': method,
      'timestamp': DateTime.now().toIso8601String(),
    });

    await _storage.write(key: 'login_history', value: jsonEncode(history));
  }

  Future<List<Map<String, dynamic>>> getLoginHistory() async {
    final existing = await _storage.read(key: _key);
    if (existing != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(existing));
    }
    return [];
  }

  Future<void> clearLoginHistory() async {
    await _storage.delete(key: _key);
  }
}
