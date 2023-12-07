import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  bool _isResend = false;

  bool _isError = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() {
    FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("Email Successfully Verified")));
      timer?.cancel();

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 7, 83, 96),
          content: Text(
            'Email verified successfully.',
          ),
        ),
      );

      setState(() {
        FirebaseAuth.instance.userChanges();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //   title: Text(
          //     'Verify your email address',
          //     style: GoogleFonts.roboto(
          //       fontWeight: FontWeight.w600,
          //       // color: const Color.fromRGBO(7, 82, 96, 1),
          //     ),
          //   ),
          //   elevation: 5.0,
          //   leading: IconButton(
          //       icon: const Icon(Icons.arrow_back, color: Colors.black),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) {
          //               return const AuthPage();
          //             },
          //           ),
          //         );
          //       }),
          ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //logo
                  const Image(
                    image: AssetImage('lib/assets/icon_small.png'),
                    height: 50,
                  ),
                  //title
                  Text(
                    'MyMeds',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(7, 82, 96, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Please verify your email address',
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      height: 1.0,
                      color: const Color.fromARGB(255, 16, 15, 15),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'We have sent you a email on ${FirebaseAuth.instance.currentUser?.email}',
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      height: 1.0,
                      color: const Color.fromARGB(255, 16, 15, 15),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),
                  const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 20),
                  Text(
                    'Waiting until verify...',
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      height: 1.0,
                      color: const Color.fromARGB(255, 16, 15, 15),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
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
                    visible: _isResend,
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.right,
                          color: const Color.fromARGB(238, 64, 93, 77),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: Color.fromARGB(238, 64, 93, 77),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Email verify link resent! Check your email.',
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(238, 64, 93, 77),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  //reset button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.currentUser
                              ?.sendEmailVerification();
                          print('Resent link sent');
                          setState(() {
                            _isResend = true;
                            _isError = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          print('Error; ${e.code}');

                          setState(() {
                            _isResend = false;
                            _isError = true;
                          });
                          //error msg
                          if (e.code == 'too-many-requests') {
                            errorMsg = 'Too many requests. Please try again';
                          } else if (e.code == 'network-request-failed') {
                            errorMsg = 'Nerwork error';
                          } else {
                            errorMsg = 'Error verifying email';
                          }
                        }
                      },
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(2),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Resend',
                        style: GoogleFonts.roboto(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  //   child: ElevatedButton(
                  //     child: const Text('Resend'),
                  //     onPressed: () {
                  //       try {
                  //         FirebaseAuth.instance.currentUser
                  //             ?.sendEmailVerification();
                  //       } catch (e) {
                  //         debugPrint('$e');
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
