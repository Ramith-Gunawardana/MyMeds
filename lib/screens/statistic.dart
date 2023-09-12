import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart and Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Statistic(),
    );
  }
}

class Statistic extends StatefulWidget {
  const Statistic({Key? key});

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  late List<GDPData> _chartData;
  late List<_ChartDataW> data;
  late TooltipBehavior _tooltip;
  late Color takenColor; // Color for the "Taken" series
  late Color missedColor; // Color for the "Missed" series
  DateTime? selectedDate; // Variable to store selected date

  @override
  void initState() {
    selectedDate = DateTime.now(); // Initialize selected date to today
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    getDataFromFirestore(formattedDate);
    _chartData = getChartData();
    data = getChartDataW();
    _tooltip = TooltipBehavior(enable: true);
    takenColor = const Color.fromRGBO(8, 142, 255, 1);
    missedColor = const Color.fromRGBO(255, 8, 136, 1);
    super.initState();
  }

  Future<void> getDataFromFirestore(String date) async {
    final medId = '6EMPsSWHpkWfjwM3oyir'; // Replace with your user ID
    var userEmail = 'marapperuma1@gmail.com';

    try {
      // Convert the date string to DateTime objects
      print(date);
      final selectedDate = DateTime.parse(date);
      final endDate = selectedDate;
      final startDate = selectedDate.subtract(Duration(days: 6));

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .collection('Medications')
          .doc(medId)
          .collection('Logs')
          .where('date',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
              isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Initialize variables to store taken and missed counts
        int takenTotal = 0;
        int missedTotal = 0;

        querySnapshot.docs.forEach((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final taken = (data['taken'] ?? 0) as int; // Cast to int
          final missed = (data['missed'] ?? 0) as int; // Cast to int

          // Aggregate daily counts for the selected week
          takenTotal += taken;
          missedTotal += missed;
        });

        setState(() {
          _chartData = [
            GDPData('Taken', takenTotal),
            GDPData('Missed', missedTotal),
          ];

          // Update data for the selected week
          data = [
            _ChartDataW('Day 1', takenTotal.toDouble(), missedTotal.toDouble()),
            _ChartDataW('Day 2', takenTotal.toDouble(), missedTotal.toDouble()),
            _ChartDataW('Day 3', takenTotal.toDouble(), missedTotal.toDouble()),
            _ChartDataW('Day 4', takenTotal.toDouble(), missedTotal.toDouble()),
            _ChartDataW('Day 5', takenTotal.toDouble(), missedTotal.toDouble()),
            _ChartDataW('Day 6', takenTotal.toDouble(), missedTotal.toDouble()),
            _ChartDataW('Day 7', takenTotal.toDouble(), missedTotal.toDouble()),
          ];
        });
      } else {
        // No data for the selected week
        print('No data for the selected week');
      }
    } catch (e) {
      // Handle errors here
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TimelineCalendar(
              calendarType: CalendarType.GREGORIAN,
              calendarLanguage: "en",
              calendarOptions: CalendarOptions(
                viewType: ViewType.DAILY,
                toggleViewType: false,
                headerMonthElevation: 0,
              ),
              onChangeDateTime: (date) {
                // Convert the CalendarDateTime object to a DateTime object.
                DateTime pickedDate = date.toDateTime();
                String dateOnly =
                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                // Call the getDataFromFirestore function with the picked date.
                getDataFromFirestore(dateOnly);
              },
            ),
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
                    enableTooltip: true,
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
                    color: takenColor,
                  ),
                  ColumnSeries<_ChartDataW, String>(
                    dataSource: data,
                    xValueMapper: (_ChartDataW data, _) => data.x,
                    yValueMapper: (_ChartDataW data, _) => data.y1,
                    name: 'Missed',
                    color: missedColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
