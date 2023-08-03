import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mymeds_app/components/alert.dart';
import 'package:mymeds_app/components/text_field.dart';
import 'package:mymeds_app/screens/password_reset.dart';
import 'package:mymeds_app/services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.showSignUpScreen});

  final void Function()? showSignUpScreen;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //controllers - keep track what types
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const Alert_Dialog(
            isError: true,
            alertTitle: 'Error',
            errorMessage: 'Email or password can\'t be empty.',
            buttonText: 'Cancel',
          );
        },
      );
    } else {
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

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (!mounted) {
          return;
        }
        //pop loading cicle
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        if (!mounted) {
          return;
        }

        //pop loading cicle
        Navigator.of(context).pop();

        showDialog(
          context: context,
          builder: (context) {
            return Alert_Dialog(
              isError: true,
              alertTitle: 'Error',
              errorMessage: e.message.toString(),
              buttonText: 'Cancel',
            );
          },
        );
      }
    }
  }

  // for memory mgt
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          // systemOverlayStyle: const SystemUiOverlayStyle(
          //     statusBarColor: Color.fromARGB(255, 233, 237, 237)),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(7, 82, 96, 1),
          ),
        ),
      ),
      // backgroundColor: const Color.fromARGB(255, 233, 237, 237),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Center(
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: const Color.fromRGBO(7, 82, 96, 1),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //logo
                    const Image(
                      image: AssetImage('lib/assets/icon_small.png'),
                      height: 80,
                    ),
                    //app name
                    Text(
                      'MyMeds',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(7, 82, 96, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //text
                    Text(
                      'Welcome back!',
                      style: GoogleFonts.poppins(
                        fontSize: 35,
                        color: const Color.fromARGB(255, 16, 15, 15),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //email
                    Text_Field(
                      label: 'Email',
                      hint: 'name@email.com',
                      isPassword: false,
                      keyboard: TextInputType.emailAddress,
                      txtEditController: _emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //password
                    Text_Field(
                      label: 'Password',
                      hint: 'Password',
                      isPassword: true,
                      keyboard: TextInputType.visiblePassword,
                      txtEditController: _passwordController,
                    ),
                    //forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              //password reset screen
                              MaterialPageRoute(
                                builder: (context) {
                                  return const PasswordReset();
                                },
                              ),
                            );
                          },
                          style: ButtonStyle(
                            // overlayColor:
                            //     MaterialStateProperty.resolveWith<Color>(
                            //   (Set<MaterialState> states) {
                            //     if (states.contains(MaterialState.pressed)) {
                            //       return const Color.fromRGBO(7, 82, 96, 1)
                            //           .withOpacity(0.2);
                            //     }
                            //     return Colors.transparent;
                            //   },
                            // ),
                            elevation: const MaterialStatePropertyAll(0),
                            backgroundColor: const MaterialStatePropertyAll(
                              Colors.transparent,
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            ),
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            'Forgot password?',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              // color: const Color.fromARGB(255, 7, 82, 96),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //sign in button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: FilledButton(
                        onPressed: signIn,
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
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'or',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 67, 63, 63),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //sign in with google buttton
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: FilledButton.tonalIcon(
                        //sign in with google
                        // onPressed: () {},
                        onPressed: () =>
                            AuthService().signInWithGoogle(context),

                        style: const ButtonStyle(
                          // overlayColor:
                          //     MaterialStateProperty.resolveWith<Color>(
                          //   (Set<MaterialState> states) {
                          //     if (states.contains(MaterialState.pressed)) {
                          //       return const Color.fromRGBO(7, 82, 96, 1)
                          //           .withOpacity(0.2);
                          //     }
                          //     return Colors.transparent;
                          //   },
                          // ),
                          elevation: MaterialStatePropertyAll(2),
                          // backgroundColor: MaterialStatePropertyAll(
                          //   Colors.white,
                          // ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          // color: Color.fromARGB(255, 7, 82, 96),
                          size: 20,
                        ),
                        label: Text(
                          'Continue with Google',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            // color: const Color.fromARGB(255, 7, 82, 96),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //link to sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 67, 63, 63),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: widget.showSignUpScreen,
                          style: ButtonStyle(
                            // overlayColor:
                            //     MaterialStateProperty.resolveWith<Color>(
                            //   (Set<MaterialState> states) {
                            //     if (states.contains(MaterialState.pressed)) {
                            //       return const Color.fromRGBO(7, 82, 96, 1)
                            //           .withOpacity(0.2);
                            //     }
                            //     return Colors.transparent;
                            //   },
                            // ),
                            elevation: const MaterialStatePropertyAll(0),
                            backgroundColor: const MaterialStatePropertyAll(
                              Colors.transparent,
                            ),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              // color: const Color.fromARGB(255, 7, 82, 96),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
