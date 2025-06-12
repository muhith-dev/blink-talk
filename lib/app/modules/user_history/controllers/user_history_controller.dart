import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserHistoryController extends GetxController {
  final _storage = const FlutterSecureStorage();
  final String _key = 'login_history';

  Future<void> saveLoginHistory(String email, String method) async {
    final existing = await _storage.read(key: _key);
    List<Map<String, dynamic>> history = [];

    if (existing != null) {
      history = List<Map<String, dynamic>>.from(jsonDecode(existing));
    }

    history.add({
      'email': email,
      'method': method,
      'timestamp': DateTime.now().toIso8601String(),
    });

    await _storage.write(key: _key, value: jsonEncode(history));
  }

  Future<List<Map<String, dynamic>>> getLoginHistory() async {
    final currentEmail = await _storage.read(key: 'email');
    final existing = await _storage.read(key: _key);

    if (existing != null && currentEmail != null) {
      final allHistory = List<Map<String, dynamic>>.from(jsonDecode(existing));

      final userHistory =
          allHistory.where((item) => item['email'] == currentEmail).toList();
      return userHistory;
    }

    return [];
  }

  Future<void> clearLoginHistory() async {
    await _storage.delete(key: _key);
  }

  Future<void> readAllData() async {
    Map<String, String> allData = await _storage.readAll();
    allData.forEach((key, value) {
      print('key : $key, value: $value');
    });
  }

  String formatTimestamp(String isoString) {
    final dateTime = DateTime.parse(isoString);
    return "${dateTime.day.toString().padLeft(2, '0')} "
        "${_monthName(dateTime.month)} ${dateTime.year} - "
        "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String _monthName(int month) {
    const months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month];
  }
}
