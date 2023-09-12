import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/user.webp',
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "In here you can edit your profile settings.",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height:10),
          const Text(
            "If you forget your password relax and try to remember your password.",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
