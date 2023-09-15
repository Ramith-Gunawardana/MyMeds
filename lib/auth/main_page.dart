import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymeds_app/auth/auth_page.dart';

import 'package:mymeds_app/screens/dashboard.dart';
import 'package:mymeds_app/screens/email_verify.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // stream: FirebaseAuth.instance.authStateChanges(),
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          //if user logged in show dashbaord else go to authentication page
          if (snapshot.hasData) {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              return const Dashboard();
            } else {
              return const EmailVerificationScreen();
            }
            // return Dashboard();
          } else {
            //auth page
            return const AuthPage();
          }
        },
      ),
    );
  }
}
