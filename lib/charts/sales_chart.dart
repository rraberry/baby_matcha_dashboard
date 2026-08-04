import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.green,
              barWidth: 4,
              spots: const [
                FlSpot(0, 20),
                FlSpot(1, 35),
                FlSpot(2, 28),
                FlSpot(3, 45),
                FlSpot(4, 55),
                FlSpot(5, 70),
                FlSpot(6, 62),
              ],
            ),
          ],
        ),
      ),
    );
  }
}