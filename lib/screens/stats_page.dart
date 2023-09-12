import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StatusBar(),
    );
  }
}

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  late List<GDPData> _chartData;
  late List<_ChartDataW> data;
  late TooltipBehavior _tooltip;
  late Color takenColor; // Color for the "Taken" series
  late Color missedColor; // Color for the "Missed" series

  @override
  void initState() {
    _chartData = getChartData();
    data = getChartDataW();
    _tooltip = TooltipBehavior(enable: true);
    takenColor = const Color.fromRGBO(8, 142, 255, 1); // Color for "Taken" series
    missedColor = const Color.fromRGBO(255, 8, 136, 1); // Color for "Missed" series
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SfCircularChart(
                title: ChartTitle(
                  text: 'Daily Dosage Usage',
                  textStyle: const TextStyle(fontSize: 20),
                ),
                legend: const Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                series: <CircularSeries>[
                  DoughnutSeries<GDPData, String>(
                    dataSource: _chartData,
                    xValueMapper: (GDPData data, _) => data.type,
                    yValueMapper: (GDPData data, _) => data.amount,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      labelAlignment: ChartDataLabelAlignment.top,
                      useSeriesColor: true,
                    ),
                    enableTooltip: true, // Enable tooltips
                    pointColorMapper: (GDPData data, _) {
                      if (data.type == 'Taken') {
                        return takenColor;
                      } else {
                        return missedColor;
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfCartesianChart(
                title: ChartTitle(
                  text: 'Weekly Dosage Usage',
                  textStyle: const TextStyle(fontSize: 20),
                ),
                legend: const Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 40, interval: 10),
                tooltipBehavior: _tooltip,
                series: <ChartSeries<_ChartDataW, String>>[
                  ColumnSeries<_ChartDataW, String>(
                    dataSource: data,
                    xValueMapper: (_ChartDataW data, _) => data.x,
                    yValueMapper: (_ChartDataW data, _) => data.y,
                    name: 'Taken',
                    color: takenColor, // Use the same color here
                  ),
                  ColumnSeries<_ChartDataW, String>(
                    dataSource: data,
                    xValueMapper: (_ChartDataW data, _) => data.x,
                    yValueMapper: (_ChartDataW data, _) => data.y1,
                    name: 'Missed',
                    color: missedColor, // Use the same color here
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<GDPData> getChartData() {
  final List<GDPData> chartData = [
    GDPData('Taken', 10),
    GDPData('Missed', 5),
  ];

  return chartData;
}

List<_ChartDataW> getChartDataW() {
  final List<_ChartDataW> data = [
    _ChartDataW('MON', 12, 5),
    _ChartDataW('TUE', 15, 34),
    _ChartDataW('WED', 30, 45),
    _ChartDataW('THU', 6, 2),
    _ChartDataW('FRI', 14, 3),
    _ChartDataW('SAT', 12, 8),
    _ChartDataW('SUN', 15, 6),
  ];

  return data;
}

class GDPData {
  GDPData(this.type, this.amount);
  final String type;
  final int amount;
}

class _ChartDataW {
  _ChartDataW(this.x, this.y, this.y1);

  final String x;
  final double y;
  final double y1;
}
