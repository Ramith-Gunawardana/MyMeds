import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/text_field.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

enum Genders { male, female, other }

class _UserProfileState extends State<UserProfile> {
  //current user
  final currentUser = FirebaseAuth.instance.currentUser;

  //controllers - keep track what types
  final _nameController = TextEditingController();
  var _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _nicController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileController = TextEditingController();

  Genders? _genderSelected;

  // for memory mgt
  @override
  void dispose() {
    _nicController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _nameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your profile',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 5,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          //get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            //update data
            _nameController.text = userData['name'] ?? '';
            _dobController.text = userData['dob'] ?? '';
            _genderController.text = userData['gender'] ?? '';
            _nicController.text = userData['nic'] ?? '';
            _addressController.text = userData['address'] ?? '';
            _mobileController.text = userData['mobile'] ?? '';

            //UI
            return GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: const Color.fromARGB(255, 7, 83, 96),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //profile pic
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      child: const Icon(
                        Icons.person_outline_rounded,
                        size: 50,
                      ),
                      // child: Image.network(currentUser!.photoURL!) ??
                      //     const Icon(
                      //       Icons.person_outline_rounded,
                      //       size: 50,
                      //     ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //email
                    Text(
                      '${currentUser!.email}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 16, 15, 15),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Text(
                          'Basic Info',
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 16, 15, 15),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // name
                    Text_Field(
                      label: 'Name',
                      hint: 'FirstName LastName',
                      isPassword: false,
                      keyboard: TextInputType.text,
                      txtEditController: _nameController,
                      focusNode: FocusNode(),
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

                    //gender
                    TextField(
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

                    //nic
                    Text_Field(
                      label: 'NIC',
                      hint: '123456789V',
                      isPassword: false,
                      keyboard: TextInputType.text,
                      txtEditController: _nicController,
                      focusNode: FocusNode(),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Contact Info',
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 16, 15, 15),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //address
                    Text_Field(
                      label: 'Address',
                      hint: 'No, Street, City',
                      isPassword: false,
                      keyboard: TextInputType.text,
                      txtEditController: _nicController,
                      focusNode: FocusNode(),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    //mobile
                    Text_Field(
                      label: 'Mobile Number',
                      hint: '07XXXXXXXX',
                      isPassword: false,
                      keyboard: TextInputType.text,
                      txtEditController: _nicController,
                      focusNode: FocusNode(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //save button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: FilledButton(
                        onPressed: () {},
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
                          'Save',
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(7, 82, 96, 1),
            ),
          );
        },
      ),
    );
  }
}
