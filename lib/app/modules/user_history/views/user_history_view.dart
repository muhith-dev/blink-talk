import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_history_controller.dart';

class UserHistoryView extends GetView<UserHistoryController> {
  const UserHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Login Pengguna'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.getLoginHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Gagal memuat data"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada riwayat login."));
          } else {
            final historyList = snapshot.data!;
            return ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(item['email']),
                  subtitle: Text(
                      '${item['method']} | ${controller.formatTimestamp(item['timestamp'])}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.readAllData();
          final confirm = await Get.dialog(
            AlertDialog(
              title: const Text("Hapus Riwayat?"),
              content: const Text("Yakin ingin menghapus semua riwayat login?"),
              actions: [
                TextButton(
                    onPressed: () => Get.back(result: false),
                    child: const Text("Batal")),
                TextButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text("Hapus")),
              ],
            ),
          );
          if (confirm == true) {
            await controller.clearLoginHistory();
            Get.snackbar("Berhasil", "Riwayat login dihapus");
            controller.update(); // Refresh UI
          }
        },
        child: const Icon(Icons.delete),
        tooltip: "Hapus Semua Riwayat",
      ),
    );
  }
}
