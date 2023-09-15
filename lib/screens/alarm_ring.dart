import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  final AlarmSettings alarmSettings;

  const AlarmScreen({Key? key, required this.alarmSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                // "You alarm (${alarmSettings.id}) is ringing...",
                'Take your medicine',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text("🔔", style: TextStyle(fontSize: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final now = DateTime.now();
                      Alarm.set(
                        alarmSettings: alarmSettings.copyWith(
                          dateTime: DateTime(
                            now.year,
                            now.month,
                            now.day,
                            now.hour,
                            now.minute,
                            0,
                            0,
                          ).add(const Duration(minutes: 1)),
                        ),
                      ).then((_) => Navigator.pop(context));
                    },
                    child: const Text(
                      "Snooze",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Alarm.stop(alarmSettings.id)
                          .then((_) => Navigator.pop(context));
                    },
                    child: const Text(
                      "Skip",
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      print('Take');
                      Alarm.stop(alarmSettings.id)
                          .then((_) => Navigator.pop(context));
                    },
                    child: const Text(
                      "Take",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
