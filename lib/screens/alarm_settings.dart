import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:mymeds_app/components/alarm_tile.dart';
import 'package:flutter/material.dart';
import 'package:mymeds_app/screens/alarm_ring.dart';

class AlarmSettingsPage extends StatefulWidget {
  const AlarmSettingsPage({Key? key}) : super(key: key);

  @override
  State<AlarmSettingsPage> createState() => _AlarmSettingsPageState();
}

class _AlarmSettingsPageState extends State<AlarmSettingsPage> {
  late List<AlarmSettings> alarms = [];

  static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    loadAlarms();
    // subscription ??= Alarm.ringStream.stream.listen(
    //   (alarmSettings) => navigateToRingScreen(alarmSettings),
    // );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlarmScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  // Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
  //   final res = await showModalBottomSheet<bool?>(
  //       context: context,
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       builder: (context) {
  //         return FractionallySizedBox(
  //           heightFactor: 0.7,
  //           child: AlarmEditScreen(alarmSettings: settings),
  //         );
  //       });

  //   if (res != null && res == true) loadAlarms();
  // }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upcoming alarms',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 5,
      ),
      body: SafeArea(
        child: alarms.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: ListView.separated(
                  itemCount: alarms.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (context, index) {
                    return AlarmTile(
                      key: Key(alarms[index].id.toString()),
                      date:
                          '${alarms[index].dateTime.toString().substring(0, 10)} ',
                      time: TimeOfDay(
                        hour: alarms[index].dateTime.hour,
                        minute: alarms[index].dateTime.minute,
                      ).format(context).toString(),
                      title: alarms[index].notificationBody.toString(),
                      onPressed: () {},
                      // onPressed: () => navigateToAlarmScreen(alarms[index]),
                      onDismissed: () {
                        Alarm.stop(alarms[index].id).then((_) => loadAlarms());
                      },
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  "No alarms set",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
      ),
    );
  }
}
