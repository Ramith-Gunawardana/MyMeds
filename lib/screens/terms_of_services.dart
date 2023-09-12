import 'package:flutter/material.dart';

class TermsOfServices extends StatelessWidget {
  const TermsOfServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms of Services"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/termsfoview.webp',
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "This mobile app serve a different purpose than documents like privacy policies or disclaimers.",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
