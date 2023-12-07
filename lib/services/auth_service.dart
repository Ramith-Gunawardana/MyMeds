import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../components/alert.dart';

class AuthService {
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    //begin interactive sign in prpcess
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential from user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    UserCredential? userCredential;
    try {
      //loading circle
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(7, 82, 96, 1),
            ),
          );
        },
      );

      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      //pop loading cicle
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      //pop loading cicle
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (context) {
          return Alert_Dialog(
            isError: true,
            alertTitle: 'Error',
            errorMessage: e.toString(),
            buttonText: 'Cancel',
          );
        },
      );
    }
    //finally, sign in
    return userCredential!;
  }
}
