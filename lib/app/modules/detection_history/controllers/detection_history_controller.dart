import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class DetectionHistoryController extends GetxController {
  final _storage = const FlutterSecureStorage();
  final String _key = 'detection_history';

  Future<void> saveDetectionMessage(String message) async {
    final List<String> excludedMessages = [
      'Deteksi dimulai. Menunggu gerakan mata...',
      'Terhubung ke server. Tekan tombol Mulai untuk memulai deteksi.',
    ];

    if (excludedMessages.contains(message)) {
      print('Pesan "$message" dikecualikan dan tidak disimpan.');
      return;
    }

    try {
      final String timestamp = DateTime.now().toIso8601String();

      String? historyJson = await _storage.read(key: 'detection_history');
      List<dynamic> historyList =
          historyJson != null ? jsonDecode(historyJson) : [];

      historyList.add({
        'message': message,
        'timestamp': timestamp,
      });

      await _storage.write(
        key: 'detection_history',
        value: jsonEncode(historyList),
      );

      print('Pesan deteksi disimpan: "$message" pada $timestamp');
    } catch (e) {
      print('Gagal menyimpan pesan deteksi: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDetectionHistory() async {
    final existingData = await _storage.read(key: _key);

    if (existingData != null) {
      final history = List<Map<String, dynamic>>.from(jsonDecode(existingData));
      return history.reversed.toList();
    }

    return [];
  }

  Future<void> printAllData() async {
    final history = await getDetectionHistory();
    print(history.toString());
  }

  Future<void> clearDetectionHistory() async {
    await _storage.delete(key: _key);
    update();
  }

  String formatTimestamp(String isoString) {
    if (isoString.isEmpty) return "Waktu tidak valid";

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
