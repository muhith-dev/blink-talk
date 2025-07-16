import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detection_history_controller.dart';

class DetectionHistoryChart extends StatelessWidget {
  DetectionHistoryChart({super.key});

  final DetectionHistoryController controller =
      Get.put(DetectionHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisa Frekuensi Pesan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, int>>(
          future: controller.getMessageFrequency(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Tidak ada data untuk ditampilkan.'));
            }
            final frequencyData = snapshot.data!;
            final chartData = frequencyData.entries.toList();

            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: (frequencyData.values.reduce((a, b) => a > b ? a : b) + 2)
                    .toDouble(), // Set nilai Y maksimum
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${chartData[groupIndex].key}\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (rod.toY - 1).toInt().toString(),
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < chartData.length) {
                          final text = chartData[index].key;
                          final displayText = text.length > 15
                              ? '${text.substring(0, 12)}...'
                              : text;
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
                            child: Text(displayText,
                                style: const TextStyle(fontSize: 10)),
                          );
                        }
                        return Container();
                      },
                      reservedSize: 42,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          if (value % 1 == 0 && value > 0) {
                            return Text(value.toInt().toString(),
                                style: const TextStyle(fontSize: 10));
                          }
                          return const Text('');
                        }),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(chartData.length, (index) {
                  final item = chartData[index];
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: item.value.toDouble() +
                            1, // Tambah 1 agar bar tidak 0
                        color: Colors.teal,
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
