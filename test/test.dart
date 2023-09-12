import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterCalendar calendar; // Declare FlutterCalendar instance
  late BarChart chart; // Declare BarChart instance

  @override
  void initState() {
    super.initState();

    // Create a new instance of the Flutter Calendar widget.
    calendar = FlutterCalendar(
      initialDate: DateTime.now(),
      firstDayOfWeek: 1, // Use 1 (Monday) as the first day of the week
    );

    // Create a new instance of the Flutter Charts widget.
    chart = BarChart(
      data: [
        BarData(
          x: 'Week', // Use x instead of label
          values: [10, 20, 30, 40, 50],
        ),
        BarData(
          x: 'Month', // Use x instead of label
          values: [60, 70, 80, 90, 100],
        ),
        BarData(
          x: 'Year', // Use x instead of label
          values: [120, 130, 140, 150, 160],
        ),
      ],
      xLabels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
      yLabels: ['0', '200', '400', '600', '800', '1000'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar and Charts',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Calendar and Charts'),
        ),
        body: Column(
          children: [
            calendar,
            chart,
          ],
        ),
      ),
    );
  }
}
