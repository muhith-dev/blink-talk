import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ChartController extends GetxController {
  var barChartData = <BarChartGroupData>[].obs;
  final mongoUrl =
      "mongodb+srv://abdulmuhithnawawi:DDyGKJWwRAHHW2pY@cluster0.5ha8rrf.mongodb.net/sign_language_db?retryWrites=true&w=majority";

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final db = await mongo.Db.create(mongoUrl);
    await db.open();
    final collection = db.collection('articles');
    final data = await collection.find().toList();

    // Hitung jumlah berita per hari
    Map<String, int> counts = {};
    for (var doc in data) {
      if (doc['scraped_at'] != null) {
        DateTime date = DateTime.parse(doc['scraped_at'].toString()).toLocal();
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        counts.update(formattedDate, (value) => value + 1, ifAbsent: () => 1);
      }
    }

    // Urutkan tanggal
    List<String> sortedDates = counts.keys.toList()..sort();

    // Buat data chart
    List<BarChartGroupData> chartData = [];
    int x = 0;
    for (var date in sortedDates) {
      chartData.add(
        BarChartGroupData(
          x: x,
          barRods: [
            BarChartRodData(
              toY: counts[date]!.toDouble(),
              width: 15,
              color: Colors.blueAccent,
            ),
          ],
        ),
      );
      x++;
    }

    barChartData.value = chartData;
    await db.close();
  }
}
