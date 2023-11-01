import 'package:flutter/material.dart';
import 'package:mymeds_app/screens/onboarding.dart';
import 'package:mymeds_app/screens/sign_in.dart';
import 'package:mymeds_app/screens/sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showSigninPage = true;
  bool showOnboarding = true;

  @override
  void initState() {
    super.initState();
  }

  void toggleScreens() {
    if (showOnboarding) {
      print('ison board?: $showOnboarding');
      setState(() {
        showOnboarding = false;
        print('false onboard');
      });
    } else {
      setState(() {
        showSigninPage = !showSigninPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showOnboarding) {
      return Onboarding(
        showSignInScreen: toggleScreens,
      );
    } else {
      if (showSigninPage) {
        return SignIn(showSignUpScreen: toggleScreens);
      } else {
        //Sign up page
        return SignUp(showSignInScreen: toggleScreens);
      }
    }
  }
}
