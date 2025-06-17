import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/buttom_navigation_bar.dart';
import '../controllers/chart_controller.dart';

class ChartPage extends GetView<ChartController> {
  const ChartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Jumlah Berita per Hari')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (controller.barChartData.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return BarChart(
                BarChartData(
                  barGroups: controller.barChartData,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text('Tanggal'),
                      axisNameSize: 16,
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          int index = value.toInt();
                          if (index >= 0 &&
                              index < controller.barChartData.length) {
                            DateTime date = DateTime.now().subtract(
                              Duration(
                                days: controller.barChartData.length - index,
                              ),
                            );
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                DateFormat('MM/dd').format(date),
                                style: const TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 30,
                        interval: 1,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              );
            }),
          ),
          Positioned(
              top: 40,
              left: 10,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/streamlit');
                },
                child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(19)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/icons/streamlit.png'),
                    )),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
