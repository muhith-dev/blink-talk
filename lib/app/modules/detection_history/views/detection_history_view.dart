import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detection_history_controller.dart';

class DetectionHistoryView extends GetView<DetectionHistoryController> {
  const DetectionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Deteksi'),
        centerTitle: true,
      ),
      body: GetBuilder<DetectionHistoryController>(
        builder: (controller) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: controller.getDetectionHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                    child: Text("Gagal memuat riwayat: ${snapshot.error}"));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Belum ada riwayat deteksi."));
              }

              final historyList = snapshot.data!;
              return ListView.builder(
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  final item = historyList[index];
                  final message =
                      item['message'] as String? ?? 'Pesan tidak valid';
                  final timestamp = item['timestamp'] as String? ?? '';

                  return ListTile(
                    leading: const Icon(Icons.visibility_outlined,
                        color: Colors.blueAccent),
                    title: Text(message),
                    subtitle: Text(controller.formatTimestamp(timestamp)),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.printAllData();
          final confirm = await Get.dialog<bool>(
            AlertDialog(
              title: const Text("Hapus Riwayat?"),
              content: const Text(
                  "Yakin ingin menghapus semua riwayat deteksi? Tindakan ini tidak dapat dibatalkan."),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text("Batal"),
                ),
                TextButton(
                  onPressed: () => Get.back(result: true),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text("Hapus"),
                ),
              ],
            ),
          );

          if (confirm == true) {
            await controller.clearDetectionHistory();
            Get.snackbar(
              "Berhasil",
              "Semua riwayat deteksi telah dihapus.",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        tooltip: 'Hapus Semua Riwayat',
        child: const Icon(Icons.delete_sweep_outlined),
      ),
    );
  }
}
