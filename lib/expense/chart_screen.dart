import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Aug 01 - Aug 31',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1000,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const Text('\$0');
                          if (value == 1000) return const Text('\$1K');
                          if (value == 2000) return const Text('\$2K');
                          if (value == 3000) return const Text('\$3K');
                          if (value == 4000) return const Text('\$4K');
                          if (value == 5000) return const Text('\$5K');
                          return const Text('');
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(weeks[value.toInt()]),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  barGroups: [
                    makeGroupData(0, 3000, 4000),
                    makeGroupData(1, 2000, 3500),
                    makeGroupData(2, 4000, 4500),
                    makeGroupData(3, 3500, 5000),
                  ],
                  maxY: 5500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LegendItem(color: Colors.teal, text: 'Income'),
                SizedBox(width: 20),
                LegendItem(color: Colors.purple, text: 'Expenses'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double income, double expense) {
    return BarChartGroupData(
      x: x,
      barsSpace: 8,
      barRods: [
        BarChartRodData(
          toY: income,
          color: Colors.teal,
          width: 14,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: expense,
          color: Colors.purple,
          width: 14,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
