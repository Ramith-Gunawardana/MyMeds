// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
// import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
// import 'package:flutter_spinner_picker/flutter_spinner_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/components/text_field.dart';
// import 'package:flutter_spinner_picker/flutter_spinner_picker.dart';
// import 'add_medication2.dart';
// import 'package:time_picker_spinner/time_picker_spinner.dart';

import 'package:day_night_time_picker/day_night_time_picker.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/screens/add_medi_frequency.dart';


class AddMedication2 extends StatefulWidget {
  const AddMedication2({Key? key}) : super(key: key);

  @override
  _AddMedication1State createState() => _AddMedication1State();
}

class _AddMedication1State extends State<AddMedication2> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final _medicationNameController = TextEditingController();
  final _medicationTypeController = TextEditingController();
  var _startingDateController = TextEditingController();
  final _medicationQuantityController = TextEditingController();
  final _medicationDosageController = TextEditingController();
  final _medicationFrequencyController = TextEditingController();
  var _medicationTimeOfDayController = TextEditingController();
  final _medicationReminderController = TextEditingController();
  final _medicationNoteController = TextEditingController();
  final _medicationPhotoController = TextEditingController();

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  var endDate;

  var startDate;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  // var time = DateTime.now();

  void _openImagePicker() {
    // Implement your image picker logic here
    // This function will be called when the image is clicked
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Medication',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          padding: const EdgeInsets.only(left: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  //navigate to add_medi_frequency.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMediFrequency(),
                    ),
                  );
                },
                child: Text('Add Medication Frequency'),
              ),

              SizedBox(height: 24),
              //this a title
              Text(
                'Medication Details',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),

              ),

              SizedBox(height: 16),
              TextField(

                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != startDate)
                    setState(() {
                      startDate = picked;
                      _startingDateController = TextEditingController(
                          text: startDate.toString().substring(0, 10));
                    });
                },
                controller: _startingDateController,

                readOnly: true,
                style: GoogleFonts.poppins(
                  height: 2,
                  color: const Color.fromARGB(255, 16, 15, 15),
                ),
                cursorColor: const Color.fromARGB(255, 7, 82, 96),
                decoration: InputDecoration(

                  hintText: 'Select the Date',
                  labelText: 'Starting Date',

                  labelStyle: GoogleFonts.poppins(
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

              SizedBox(height: 16),
              TextField(
                onTap: () {
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: _time,
                      sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                      sunset: TimeOfDay(hour: 18, minute: 0), // optional
                      duskSpanInMinutes: 120, // optional
                      onChange: onTimeChanged,
                      iosStylePicker: iosStyle,
                      is24HrFormat: false,
                      blurredBackground: true,
                      // Optional onChange to receive value as DateTime
                      //just the hour and minute as integers
                      onChangeDateTime: (DateTime dateTime) {
                        setState(() {
                          _medicationTimeOfDayController =
                              TextEditingController(
                                  text: TimeOfDay.fromDateTime(dateTime)
                                      .format(context));
                        });
                        print(dateTime);
                      },
                    ),
                  );
                },
                controller: _medicationTimeOfDayController,
                readOnly: true,
                style: GoogleFonts.poppins(

                  height: 2,
                  color: const Color.fromARGB(255, 16, 15, 15),
                ),
                cursorColor: const Color.fromARGB(255, 7, 82, 96),
                decoration: InputDecoration(

                  hintText: 'Select the Time',
                  labelText: 'Medication Time of Day',
                  labelStyle: GoogleFonts.poppins(

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

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .collection('medications')
                        .add({
                      'medicationName': _medicationNameController.text,
                      'medicationType': _medicationTypeController.text,
                      'medicationQuantity': _medicationQuantityController.text,
                      'medicationDosage': _medicationDosageController.text,
                      'medicationFrequency':
                          _medicationFrequencyController.text,
                      'medicationTimeOfDay':
                          _medicationTimeOfDayController.text,
                      'medicationReminder': _medicationReminderController.text,
                      'medicationNote': _medicationNoteController.text,
                      'medicationPhoto': _medicationPhotoController.text,
                    });
                    //navigate to add_medicine2
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}