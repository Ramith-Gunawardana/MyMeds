import 'package:flutter/material.dart';

class NotificationSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Settings"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/4ewS.gif',
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Now you can edit your notification settings in here",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
