import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/callcenter.gif',
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "If you have any problem with this app please call 911.",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height:10),
          const Text(
           "We are like to help your any problem",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
