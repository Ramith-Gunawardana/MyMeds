import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

import 'package:mymeds_app/components/alert.dart';

import '../components/text_field.dart';
import '../services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.showSignInScreen});

  final void Function()? showSignInScreen;
  @override
  State<SignUp> createState() => _SignUpState();
}

enum Genders { male, female, other }

class _SignUpState extends State<SignUp> {
  //controllers - keep track what types
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();
  var _dobController = TextEditingController();
  final _genderController = TextEditingController();

  Genders? _genderSelected;

  Future signUp() async {
    try {
      if (_emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _confirmpasswordController.text.isEmpty) {
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
        if (isPasswordConfirmed()) {
          //create user
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          //add user data
          // addUserData(
          //   _nameController.text.trim(),
          //   _dobController.text.trim(),
          //   _genderController.text.trim(),
          //   _emailController.text.trim(),
          // );
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.email)
              .set(
            {
              'name': _nameController.text.trim(),
              'dob': _dobController.text.trim(),
              'gender': _genderController.text.trim(),
              'nic': null,
              'address': null,
              'mobile': null,
            },
          );

          if (!mounted) {
            return;
          }
          showDialog(
            context: context,
            builder: (context) {
              return const Alert_Dialog(
                isError: false,
                alertTitle: 'Alert',
                errorMessage: 'Account created successfully',
                buttonText: 'Ok',
              );
            },
          );
        }
      }
    } on FirebaseAuthException catch (e) {
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

  Future addUserData(
      String name, String dob, String gender, String email) async {
    // await FirebaseFirestore.instance.collection('users').add(
    //   {
    //     'name': name,
    //     'dob': dob,
    //     'gender': gender,
    //     'email': email,
    //   },
    // );
  }

  bool isPasswordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const Alert_Dialog(
            isError: true,
            alertTitle: 'Error',
            errorMessage: 'Passwords mismatch',
            buttonText: 'Ok',
          );
        },
      );
      return false;
    }
  }

  // for memory mgt
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _nameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
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
            // elevation: 0,
            // iconTheme: const IconThemeData(
            //     color: Color.fromRGBO(7, 82, 96, 1),
            //     ),
            ),
      ),
      // backgroundColor: const Color.fromARGB(255, 233, 237, 237),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Center(
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: const Color.fromARGB(255, 7, 83, 96),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        //text
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Let\'s \nGet Started',
                            style: GoogleFonts.roboto(
                              fontSize: 35,
                              height: 1.0,
                              color: const Color.fromARGB(255, 16, 15, 15),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            //logo
                            const Image(
                              image: AssetImage('lib/assets/icon_small.png'),
                              height: 50,
                            ),
                            //title
                            Text(
                              'MyMeds',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(7, 82, 96, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // ElevatedButton(
                    //   child: Text("open picker dialog"),
                    //   onPressed: () async {
                    //     var datePicked = await DatePicker.showSimpleDatePicker(
                    //       context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(1900),
                    //       lastDate: DateTime(2099),
                    //       dateFormat: "dd-MMMM-yyyy",
                    //       locale: DateTimePickerLocale.en_us,
                    //       looping: true,
                    //     );

                    //     final snackBar =
                    //         SnackBar(content: Text("Date Picked $datePicked"));
                    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //   },
                    // ),

                    //name
                    Text_Field(
                      label: 'Name',
                      hint: 'FirstName LastName',
                      isPassword: false,
                      keyboard: TextInputType.text,
                      txtEditController: _nameController,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //date of birth
                    TextField(
                      onTap: () async {
                        var datePicked = await DatePicker.showSimpleDatePicker(
                          context,
                          titleText: 'Select your birthday',
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2099),
                          dateFormat: "dd-MMMM-yyyy",
                          locale: DateTimePickerLocale.en_us,
                          looping: true,
                        );
                        String date =
                            '${datePicked!.day}-${datePicked.month}-${datePicked.year}';

                        setState(() {
                          _dobController = TextEditingController(text: date);
                        });
                      },
                      controller: _dobController,
                      readOnly: true,
                      style: GoogleFonts.roboto(
                        height: 2,
                        color: const Color.fromARGB(255, 16, 15, 15),
                      ),
                      cursorColor: const Color.fromARGB(255, 7, 82, 96),
                      decoration: InputDecoration(
                        hintText: 'DD-MM-YYYY',
                        labelText: 'Date of Birth',
                        labelStyle: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 16, 15, 15),
                        ),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        // fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 7, 82, 96),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    // DropdownMenu(
                    //   dropdownMenuEntries: [
                    //     DropdownMenuEntry(value: 'Male', label: 'Male'),
                    //     DropdownMenuEntry(value: 'Female', label: 'Female'),
                    //     DropdownMenuEntry(value: 'Other', label: 'Other'),
                    //   ],
                    //   label: Text('Gender'),
                    // ),

                    //gender
                    TextField(
                      // onTap: () async {
                      //   DropdownButtonFormField(
                      //     items: [
                      //       DropdownMenuItem(
                      //         child: Text('Male'),
                      //       ),
                      //       DropdownMenuItem(
                      //         child: Text('Female'),
                      //       ),
                      //       DropdownMenuItem(
                      //         child: Text('Other'),
                      //       ),
                      //     ],
                      //     onChanged: (value) {},
                      //   );
                      // },
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Select your gender',
                              style: GoogleFonts.roboto(
                                color: const Color.fromARGB(255, 16, 15, 15),
                              ),
                            ),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    RadioListTile(
                                      value: Genders.male,
                                      title: const Text('Male'),
                                      groupValue: _genderSelected,
                                      onChanged: (Genders? vale) {
                                        setState(
                                          () {
                                            _genderSelected = vale;
                                            _genderController.text = 'Male';
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                    RadioListTile(
                                      value: Genders.female,
                                      title: const Text('Female'),
                                      groupValue: _genderSelected,
                                      onChanged: (Genders? vale) {
                                        setState(
                                          () {
                                            _genderSelected = vale;
                                            _genderController.text = 'Female';
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                    RadioListTile(
                                      value: Genders.other,
                                      title: const Text('Other'),
                                      groupValue: _genderSelected,
                                      onChanged: (Genders? vale) {
                                        setState(
                                          () {
                                            _genderSelected = vale;
                                            _genderController.text = 'Other';
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                      controller: _genderController,
                      readOnly: true,
                      style: GoogleFonts.roboto(
                        height: 2,
                        color: const Color.fromARGB(255, 16, 15, 15),
                      ),
                      cursorColor: const Color.fromARGB(255, 7, 82, 96),
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 16, 15, 15),
                        ),
                        hintText: 'Gender',
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        // fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 7, 82, 96),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
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

                    const SizedBox(
                      height: 15,
                    ),

                    //confirm password
                    Text_Field(
                      label: 'Confirm Password',
                      hint: 'Password',
                      isPassword: true,
                      keyboard: TextInputType.visiblePassword,
                      txtEditController: _confirmpasswordController,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    //sign up
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: FilledButton(
                        onPressed: signUp,
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
                          'Sign Up',
                          style: GoogleFonts.roboto(
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
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 67, 63, 63),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //google
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: FilledButton.tonalIcon(
                        onPressed: () async {
                          UserCredential userCredential =
                              await AuthService().signInWithGoogle(context);
                          print(userCredential.user!.email);
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(userCredential.user!.email)
                              .set(
                            {
                              'name': userCredential.user!.displayName,
                              'dob': null,
                              'gender': null,
                              'nic': null,
                              'address': null,
                              'mobile': userCredential.user!.phoneNumber,
                            },
                          );
                        },
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
                          // backgroundColor: const MaterialStatePropertyAll(
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
                          'Sign up with Google',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            // color: const Color.fromARGB(255, 7, 82, 96),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //redirect to register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 67, 63, 63),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: widget.showSignInScreen,
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
                            'Sign In',
                            style: GoogleFonts.roboto(
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
