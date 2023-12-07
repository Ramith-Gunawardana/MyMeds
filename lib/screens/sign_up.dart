import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();

  late FocusNode focusNode_email;
  late FocusNode focusNode_pwd;
  late FocusNode focusNode_pwdConfirm;
  late FocusNode focusNode_name;
  late FocusNode focusNode_dob;
  late FocusNode focusNode_gender;

  bool _isEmail = false;
  bool _isName = false;
  bool _isPwd = false;
  bool _isPwdConfirm = false;

  bool isLoading = false;
  bool isLoadingGoogle = false;

  bool _isError = false;
  bool _isSuccess = false;
  //firebase error message
  String errorMsg = '';

  Genders? _genderSelected;

  bool isName(String input) => RegExp(r'^[a-zA-Z]').hasMatch(input);
  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);
  bool isPassword(String input) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(input);

  @override
  void initState() {
    focusNode_email = FocusNode();
    focusNode_pwd = FocusNode();
    focusNode_pwdConfirm = FocusNode();
    focusNode_name = FocusNode();
    focusNode_dob = FocusNode();
    focusNode_gender = FocusNode();
    super.initState();
  }

  bool isPasswordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    //check empty fields
    if (_nameController.text.isEmpty) {
      focusNode_name.requestFocus();
      // } else if (_dobController.text.isEmpty) {
      //   focusNode_dob.requestFocus();
      // } else if (_genderController.text.isEmpty) {
      //   focusNode_gender.requestFocus();
    } else if (_emailController.text.isEmpty) {
      focusNode_email.requestFocus();
    } else if (_passwordController.text.isEmpty) {
      focusNode_pwd.requestFocus();
    } else if (_confirmpasswordController.text.isEmpty) {
      focusNode_pwdConfirm.requestFocus();
    } else {
      //check input validation (RegEx)
      if (!isName(_nameController.text)) {
        //show error
        setState(() {
          _isName = true;
        });
      } else {
        //hide error
        setState(() {
          _isName = false;
        });
      }
      if (!isEmail(_emailController.text)) {
        setState(() {
          _isEmail = true;
        });
      } else {
        setState(() {
          _isEmail = false;
        });
      }
      if (!isPassword(_passwordController.text)) {
        setState(() {
          _isPwd = true;
        });
      } else {
        setState(() {
          _isPwd = false;
        });

        try {
          //check confirm password
          if (isPasswordConfirmed()) {
            //passwords mismatch
            setState(() {
              _isPwdConfirm = false;
            });
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
            //create user
            UserCredential userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userCredential.user!.email)
                .set(
              {
                'name': _nameController.text.trim(),
                'dob': null,
                'gender': null,
                'nic': null,
                'address': null,
                'mobile': null,
              },
            );

            // if (!mounted) {
            //   return;
            // }

            //pop loading cicle
            // Navigator.of(context).pop();

            //account created successfully
            setState(() {
              _isError = false;
              _isSuccess = true;
              isLoading = false;
            });

            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return const Alert_Dialog(
            //       isError: false,
            //       alertTitle: 'Alert',
            //       errorMessage: 'Account created successfully',
            //       buttonText: 'Ok',
            //     );
            //   },
            // );
          } else {
            //passwords mismatch
            setState(() {
              _isPwdConfirm = true;
            });
          }
        } on FirebaseAuthException catch (e) {
          //firebase error
          setState(() {
            _isError = true;
            _isSuccess = false;
            isLoading = false;
            errorMsg = getErrorMessage(e.code);
          });

          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return Alert_Dialog(
          //       isError: true,
          //       alertTitle: 'Error',
          //       errorMessage: e.message.toString(),
          //       buttonText: 'Cancel',
          //     );
          //   },
          // );

          //pop loading cicle
          // Navigator.of(context).pop();
        }
      }

      //   try {
      //     if (_emailController.text.isEmpty ||
      //         _passwordController.text.isEmpty ||
      //         _confirmpasswordController.text.isEmpty) {
      //       showDialog(
      //         context: context,
      //         builder: (context) {
      //           return const Alert_Dialog(
      //             isError: true,
      //             alertTitle: 'Error',
      //             errorMessage: 'Email or password can\'t be empty.',
      //             buttonText: 'Cancel',
      //           );
      //         },
      //       );
      //     } else {
      //       if (isPasswordConfirmed()) {
      //         //create user
      //         UserCredential userCredential =
      //             await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //           email: _emailController.text.trim(),
      //           password: _passwordController.text.trim(),
      //         );

      //         await FirebaseFirestore.instance
      //             .collection('Users')
      //             .doc(userCredential.user!.email)
      //             .set(
      //           {
      //             'name': _nameController.text.trim(),
      //             'dob': _dobController.text.trim(),
      //             'gender': _genderController.text.trim(),
      //             'nic': null,
      //             'address': null,
      //             'mobile': null,
      //           },
      //         );

      //         if (!mounted) {
      //           return;
      //         }
      //         showDialog(
      //           context: context,
      //           builder: (context) {
      //             return const Alert_Dialog(
      //               isError: false,
      //               alertTitle: 'Alert',
      //               errorMessage: 'Account created successfully',
      //               buttonText: 'Ok',
      //             );
      //           },
      //         );
      //       }
      //     }
      //   } on FirebaseAuthException catch (e) {
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return Alert_Dialog(
      //           isError: true,
      //           alertTitle: 'Error',
      //           errorMessage: e.message.toString(),
      //           buttonText: 'Cancel',
      //         );
      //       },
      //     );
    }
  }

  //used for testing
  // Future signUp() async {
  //   try {
  //     //create user
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );

  //     //account created successfully
  //     setState(() {
  //       _isError = false;
  //       _isSuccess = true;
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     //firebase error
  //     setState(() {
  //       _isError = true;
  //       _isSuccess = false;
  //       errorMsg = getErrorMessage(e.code);
  //     });
  //   }
  // }

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
                              style: GoogleFonts.poppins(
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
                      height: 40,
                    ),

                    //name
                    Text_Field(
                      label: 'Name',
                      hint: 'FirstName LastName',
                      isPassword: false,
                      keyboard: TextInputType.text,
                      txtEditController: _nameController,
                      focusNode: focusNode_name,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    //text not a valid name
                    Visibility(
                      visible: _isName,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text(
                            'Enter a valid name',
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

                    //date of birth
                    // TextField(
                    //   onTap: () async {
                    //     var datePicked = await DatePicker.showSimpleDatePicker(
                    //       context,
                    //       titleText: 'Select your birthday',
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(1900),
                    //       lastDate: DateTime(2099),
                    //       dateFormat: "dd-MMMM-yyyy",
                    //       locale: DateTimePickerLocale.en_us,
                    //       looping: true,
                    //     );
                    //     String date =
                    //         '${datePicked!.day}-${datePicked.month}-${datePicked.year}';

                    //     setState(() {
                    //       _dobController = TextEditingController(text: date);
                    //     });
                    //   },
                    //   focusNode: focusNode_dob,
                    //   controller: _dobController,
                    //   readOnly: true,
                    //   style: GoogleFonts.roboto(
                    //     height: 2,
                    //     color: const Color.fromARGB(255, 16, 15, 15),
                    //   ),
                    //   cursorColor: const Color.fromARGB(255, 7, 82, 96),
                    //   decoration: InputDecoration(
                    //     hintText: 'DD-MM-YYYY',
                    //     labelText: 'Date of Birth',
                    //     labelStyle: GoogleFonts.roboto(
                    //       color: const Color.fromARGB(255, 16, 15, 15),
                    //     ),
                    //     filled: true,
                    //     floatingLabelBehavior: FloatingLabelBehavior.auto,
                    //     // fillColor: Colors.white,
                    //     focusedBorder: const OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(
                    //           20,
                    //         ),
                    //       ),
                    //       borderSide: BorderSide(
                    //         color: Color.fromARGB(255, 7, 82, 96),
                    //       ),
                    //     ),
                    //     enabledBorder: const OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(
                    //           20,
                    //         ),
                    //       ),
                    //       borderSide: BorderSide(
                    //         color: Colors.transparent,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // const SizedBox(
                    //   height: 18,
                    // ),

                    // DropdownMenu(
                    //   controller: _genderController,
                    //   textStyle: GoogleFonts.roboto(
                    //     height: 2,
                    //     color: const Color.fromARGB(255, 16, 15, 15),
                    //   ),
                    //   width: MediaQuery.of(context).size.width * 0.82,
                    //   menuStyle: const MenuStyle(
                    //     shape: MaterialStatePropertyAll(
                    //       RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(20),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   inputDecorationTheme: const InputDecorationTheme(
                    //     filled: true,
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(
                    //           20,
                    //         ),
                    //       ),
                    //       borderSide: BorderSide(
                    //         color: Color.fromARGB(255, 7, 82, 96),
                    //       ),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(
                    //           20,
                    //         ),
                    //       ),
                    //       borderSide: BorderSide(
                    //         color: Colors.transparent,
                    //       ),
                    //     ),
                    //   ),
                    //   dropdownMenuEntries: const [
                    //     DropdownMenuEntry(value: 'Male', label: 'Male'),
                    //     DropdownMenuEntry(value: 'Female', label: 'Female'),
                    //     DropdownMenuEntry(value: 'Other', label: 'Other'),
                    //   ],
                    //   label: const Text('Gender'),
                    // ),

                    //gender
                    // TextField(
                    //   // onTap: () async {
                    //   //   DropdownButtonFormField(
                    //   //     items: [
                    //   //       DropdownMenuItem(
                    //   //         child: Text('Male'),
                    //   //       ),
                    //   //       DropdownMenuItem(
                    //   //         child: Text('Female'),
                    //   //       ),
                    //   //       DropdownMenuItem(
                    //   //         child: Text('Other'),
                    //   //       ),
                    //   //     ],
                    //   //     onChanged: (value) {},
                    //   //   );
                    //   // },
                    //   focusNode: focusNode_gender,
                    //   onTap: () => showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text(
                    //           'Select your gender',
                    //           style: GoogleFonts.roboto(
                    //             color: const Color.fromARGB(255, 16, 15, 15),
                    //           ),
                    //         ),
                    //         content: StatefulBuilder(
                    //           builder:
                    //               (BuildContext context, StateSetter setState) {
                    //             return Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //                 RadioListTile(
                    //                   value: Genders.male,
                    //                   title: const Text('Male'),
                    //                   groupValue: _genderSelected,
                    //                   onChanged: (Genders? vale) {
                    //                     setState(
                    //                       () {
                    //                         _genderSelected = vale;
                    //                         _genderController.text = 'Male';
                    //                         Navigator.of(context).pop();
                    //                       },
                    //                     );
                    //                   },
                    //                 ),
                    //                 RadioListTile(
                    //                   value: Genders.female,
                    //                   title: const Text('Female'),
                    //                   groupValue: _genderSelected,
                    //                   onChanged: (Genders? vale) {
                    //                     setState(
                    //                       () {
                    //                         _genderSelected = vale;
                    //                         _genderController.text = 'Female';
                    //                         Navigator.of(context).pop();
                    //                       },
                    //                     );
                    //                   },
                    //                 ),
                    //                 RadioListTile(
                    //                   value: Genders.other,
                    //                   title: const Text('Other'),
                    //                   groupValue: _genderSelected,
                    //                   onChanged: (Genders? vale) {
                    //                     setState(
                    //                       () {
                    //                         _genderSelected = vale;
                    //                         _genderController.text = 'Other';
                    //                         Navigator.of(context).pop();
                    //                       },
                    //                     );
                    //                   },
                    //                 ),
                    //               ],
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    //   controller: _genderController,
                    //   readOnly: true,
                    //   style: GoogleFonts.roboto(
                    //     height: 2,
                    //     color: const Color.fromARGB(255, 16, 15, 15),
                    //   ),
                    //   cursorColor: const Color.fromARGB(255, 7, 82, 96),
                    //   decoration: InputDecoration(
                    //     labelText: 'Gender',
                    //     labelStyle: GoogleFonts.roboto(
                    //       color: const Color.fromARGB(255, 16, 15, 15),
                    //     ),
                    //     hintText: 'Gender',
                    //     filled: true,
                    //     floatingLabelBehavior: FloatingLabelBehavior.auto,
                    //     // fillColor: Colors.white,
                    //     focusedBorder: const OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(
                    //           20,
                    //         ),
                    //       ),
                    //       borderSide: BorderSide(
                    //         color: Color.fromARGB(255, 7, 82, 96),
                    //       ),
                    //     ),
                    //     enabledBorder: const OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(
                    //           20,
                    //         ),
                    //       ),
                    //       borderSide: BorderSide(
                    //         color: Colors.transparent,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // const SizedBox(
                    //   height: 18,
                    // ),

                    //email
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

                    //password
                    Text_Field(
                      label: 'Password',
                      hint: 'Password',
                      isPassword: true,
                      keyboard: TextInputType.visiblePassword,
                      txtEditController: _passwordController,
                      focusNode: focusNode_pwd,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    //text not a valid password
                    Visibility(
                      visible: _isPwd,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text(
                            'Enter a strong password',
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

                    //confirm password
                    Text_Field(
                      label: 'Confirm Password',
                      hint: 'Password',
                      isPassword: true,
                      keyboard: TextInputType.visiblePassword,
                      txtEditController: _confirmpasswordController,
                      focusNode: focusNode_pwdConfirm,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    //text password mismatch
                    Visibility(
                      visible: _isPwdConfirm,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text(
                            'Passwords do not match',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: const Color.fromRGBO(255, 16, 15, 15),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
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
                                    color:
                                        const Color.fromRGBO(255, 16, 15, 15),
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
                      visible: _isSuccess,
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
                                  'Account created successfully!',
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        const Color.fromARGB(239, 0, 198, 89),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //sign up button
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
                        child: !isLoading
                            ? Text(
                                'Sign Up',
                                style: GoogleFonts.roboto(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white,
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
                          setState(() {
                            isLoading = true;
                          });
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
                              'mobile': null,
                            },
                          );
                          setState(() {
                            isLoading = false;
                          });
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
                          color: Color.fromARGB(255, 7, 82, 96),
                          size: 20,
                        ),
                        label: !isLoading
                            ? Text(
                                'Sign up with Google',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 7, 82, 96),
                                ),
                              )
                            : const CircularProgressIndicator(
                                color: Color.fromARGB(255, 7, 82, 96),
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

  // firebase error messages
  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Email already used. Go to Sign In page.';
      case 'operation-not-allowed':
        return 'Operation is not allowed.';
      case 'invalid-email':
        return 'Email address is invalid.';
      case 'weak-password':
        return 'Enter a strong password.';
      case 'network-request-failed':
        return 'Network error.';
      default:
        return 'Account creation failed. Please try again';
    }
  }
}
