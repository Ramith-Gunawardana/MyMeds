import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/text_field.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _emailController = TextEditingController();

  late FocusNode focusNode_email;

  bool _isEmail = false;
  bool _isRest = false;

  bool isLoading = false;

  bool _isError = false;
  String errorMsg = '';

  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);

  @override
  void initState() {
    super.initState();
    focusNode_email = FocusNode();
  }

  Future passwordReset() async {
    if (_emailController.text.isEmpty) {
      focusNode_email.requestFocus();
    } else {
      if (!isEmail(_emailController.text)) {
        setState(() {
          _isEmail = true;
        });
      } else {
        setState(() {
          _isEmail = false;
        });
        try {
          //loading circle
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return const Center(
          //       child: CircularProgressIndicator(
          //         color: Color.fromRGBO(7, 82, 96, 1),
          //       ),
          //     );
          //   },
          // );

          setState(() {
            isLoading = true;
          });

          await FirebaseAuth.instance.sendPasswordResetEmail(
            email: _emailController.text.trim(),
          );

          // if (!mounted) {
          //   return;
          // }

          setState(() {
            _isRest = true;
            _isError = false;
            isLoading = false;
          });
        } on FirebaseAuthException catch (e) {
          print(e.code);
          // if (!mounted) {
          //   return;
          // }

          //pop loading cicle
          // Navigator.of(context).pop();

          setState(() {
            _isError = true;
            _isRest = false;
            isLoading = false;
            errorMsg = getErrorMessage(e.code);
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 233, 237, 237),
      appBar: AppBar(
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarColor: Color.fromARGB(255, 233, 237, 237)),
        elevation: 5,
        // iconTheme: const IconThemeData(
        //   color: Color.fromRGBO(7, 82, 96, 1),
        // ),
        title: Text(
          'Reset your password',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            // color: const Color.fromRGBO(7, 82, 96, 1),
          ),
        ),
        // backgroundColor: const Color.fromRGBO(7, 82, 96, 1),
      ),
      body: Container(
        margin: const EdgeInsets.all(35),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //text
              Text(
                'Enter the email address associated with your account',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 16, 15, 15),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              //email txtfield
              Text_Field(
                label: 'Email',
                hint: 'name@email.com',
                isPassword: false,
                keyboard: TextInputType.emailAddress,
                txtEditController: _emailController,
                focusNode: focusNode_email,
              ),
              const SizedBox(
                height: 2,
              ),
              //text not a valid email
              Visibility(
                visible: _isEmail,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      'Enter a valid email address',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: const Color.fromRGBO(255, 16, 15, 15),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //firebase error message
              Visibility(
                visible: _isError,
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.right,
                      color: const Color.fromRGBO(255, 16, 15, 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: Color.fromRGBO(255, 16, 15, 15),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            errorMsg,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(255, 16, 15, 15),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //success message
              Visibility(
                visible: _isRest,
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.right,
                      color: const Color.fromARGB(239, 0, 198, 89),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Color.fromARGB(239, 0, 198, 89),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Password reset link sent! Check your email.',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(239, 0, 198, 89),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              //button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: passwordReset,
                  style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(2),
                    // backgroundColor: MaterialStatePropertyAll(
                    //   Color.fromARGB(255, 7, 82, 96),
                    // ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  child: !isLoading
                      ? Text(
                          'Reset Password',
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // firebase error messages
  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-disabled':
        return "User disabled.";
      case 'user-not-found':
        return 'No user found with this email.';
      case 'weak-password':
        return 'Please enter a strong password';
      case 'invalid-action-code':
        return 'Invalid action code. Please try again';
      case 'expired-action-cod':
        return 'Action code is expired.';
      case 'network-request-failed':
        return 'Network error.';
      default:
        return 'Error while resetting password.';
    }
  }
}
