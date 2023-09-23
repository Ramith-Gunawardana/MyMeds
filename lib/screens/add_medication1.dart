// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/components/text_field.dart';
import 'add_medication2.dart';
import 'package:mymeds_app/components/category_model.dart';
// import 'package:time_picker_spinner/time_picker_spinner.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// import 'package:show_time_picker/show_time_picker.dart';

class AddMedication1 extends StatefulWidget {
  // List<Category> categories = [
  //   Category('Pill', Icons.medication),
  //   Category('Liquid', Icons.medication),
  //   Category('Inhaler', Icons.medication),
  //   Category('Injection', Icons.medication),
  //   Category('Cream', Icons.medication),
  //   Category('Patch', Icons.medication),
  //   Category('Suppository', Icons.medication),
  //   Category('Other', Icons.medication),
  // ];

  List<CategoryModel> categories = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
  }

  // void _getCategories() {
  //   categories = CategoryModel.getCategories();
  // }

  @override
  _AddMedication1State createState() => _AddMedication1State();
}

enum Units {
  mg,
  mcg,
  g,
  ml,
  percentage, // Instead of %
  IU,
  oz,
  tsp,
  tbsp,
  cup,
  pt,
  qt,
  gal,
  lb,
  mg_per_ml // Instead of mg/mL
}

String unitToString(Units unit) {
  switch (unit) {
    case Units.mg:
      return 'mg';
    case Units.mcg:
      return 'mcg';
    case Units.g:
      return 'g';
    case Units.ml:
      return 'ml';
    case Units.percentage:
      return '%';
    case Units.IU:
      return 'IU';
    case Units.oz:
      return 'oz';
    case Units.tsp:
      return 'tsp';
    case Units.tbsp:
      return 'tbsp';
    case Units.cup:
      return 'cup';
    case Units.pt:
      return 'pt';
    case Units.qt:
      return 'qt';
    case Units.gal:
      return 'gal';
    case Units.lb:
      return 'lb';
    case Units.mg_per_ml:
      return 'mg/mL';
    default:
      return ''; // Handle any unexpected cases
  }
}

Units? _units;

// class Category {
//   final String name;
//   final String iconPath;
//   Color boxColor;
//   bool isSelected;

//   Category({
//     required this.name,
//     required this.iconPath,
//     this.boxColor = Colors.white,
//     this.isSelected = false,
//   });
// }

// class CategoriesWidget extends StatefulWidget {
//   final List<Category> categories;

//   CategoriesWidget({required this.categories});

//   @override
//   _AddMedication1State createState() => _AddMedication1State();
// }

class _AddMedication1State extends State<AddMedication1> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final _medicationNameController = TextEditingController();
  final _medicationTypeController = TextEditingController();
  final _medicationStrengthController = TextEditingController();
  final _medicationQuantityController = TextEditingController();
  final _medicationDosageController = TextEditingController();
  final _medicationFrequencyController = TextEditingController();
  var _medicationTimeOfDayController = TextEditingController();
  final _medicationStrengthValueController = TextEditingController();
  final _medicationNoteController = TextEditingController();
  final _medicationPhotoController = TextEditingController();

  // var time = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._getInitialInfo();
  }

  void _openImagePicker() {
    // Implement your image picker logic here
    // This function will be called when the image is clicked
  }

  @override
  Widget build(BuildContext context) {
    widget._getInitialInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Medication',
          style: TextStyle(
            // color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 5.0,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        //   padding: const EdgeInsets.only(left: 20),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        // centerTitle: true,
        // backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              GestureDetector(
                onTap: _openImagePicker,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 16, bottom: 10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.add_a_photo, size: 50),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, left: 10),
                child: Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 8),
              // Text_Field(
              //   label: 'Medication Name',
              //   hint: 'Medicine',
              //   isPassword: false,
              //   keyboard: TextInputType.text,
              //   txtEditController: _medicationNameController,
              // ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  'Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 120,
                child: ListView.separated(
                  itemCount: widget.categories.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: widget.categories[index].boxColor
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)),
                      child: GestureDetector(
                        onTap: () {
                          print('Tapped category: ${index}');
                          setState(() {
                            widget.categories[index].boxColor =
                                const Color.fromARGB(255, 7, 82, 96);
                            widget.categories[index].isSelected = true;
                          });

                          for (int i = 0; i < widget.categories.length; i++) {
                            if (i != index) {
                              setState(() {
                                widget.categories[i].boxColor =
                                    Colors.transparent;
                                widget.categories[i].isSelected = false;
                              });
                            }
                          }

                          _medicationTypeController.text =
                              widget.categories[index].name;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    widget.categories[index].iconPath,
                                  ),
                                )),
                            Text(
                              widget.categories[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  'Strength',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _medicationStrengthValueController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the medication strength';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 7, 82, 96),
                      decoration: InputDecoration(
                        hintText: '0.0',
                        labelText: 'Strength Value',
                        labelStyle: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 16, 15, 15),
                        ),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 7, 82, 96),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add spacing between the two text fields
                  Expanded(
                    child: TextFormField(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Select the Medication Strength',
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 16, 15, 15),
                              ),
                            ),
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (Units unit in Units.values)
                                        RadioListTile<Units>(
                                          title: Text(
                                            unitToString(unit),
                                            style: GoogleFonts.poppins(
                                              color: const Color.fromARGB(
                                                  255, 16, 15, 15),
                                            ),
                                          ),
                                          value: unit,
                                          groupValue: _units,
                                          onChanged: (Units? value) {
                                            setState(() {
                                              _units = value;
                                              _medicationStrengthController
                                                  .text = unitToString(value!);
                                              Navigator.pop(
                                                  context); // Close the dialog
                                            });
                                          },
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            actions: [
                              // ... OK and Cancel buttons ...
                              //by clicking on the cancel button the dialog will be closed and the selected value should be cleared

                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.poppins(
                                    color:
                                        const Color.fromARGB(255, 16, 15, 15),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Ok',
                                  style: GoogleFonts.poppins(
                                    color:
                                        const Color.fromARGB(255, 16, 15, 15),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      controller: _medicationStrengthController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the medication strength';
                        }
                        return null;
                      },
                      readOnly: true, // Prevent direct input
                      cursorColor: const Color.fromARGB(255, 7, 82, 96),
                      decoration: InputDecoration(
                        labelText: 'Unit',
                        labelStyle: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 16, 15, 15),
                        ),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 7, 82, 96),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _medicationNoteController,
                decoration: InputDecoration(
                    labelText: 'Medication Note',
                    hintText: 'Take note about this medication'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  //   await FirebaseFirestore.instance
                  //       .collection('users')
                  //       .doc(user!.uid)
                  //       .collection('medications')
                  //       .add({
                  //     'medicationName': _medicationNameController.text,
                  //     'medicationType': _medicationTypeController.text,
                  //     'medicationQuantity': _medicationQuantityController.text,
                  //     'medicationDosage': _medicationDosageController.text,
                  //     'medicationFrequency':
                  //         _medicationFrequencyController.text,
                  //     'medicationTimeOfDay':
                  //         _medicationTimeOfDayController.text,
                  //     'medicationReminder': _medicationReminderController.text,
                  //     'medicationNote': _medicationNoteController.text,
                  //     'medicationPhoto': _medicationPhotoController.text,
                  //   });
                  //   //navigate to add_medicine2
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => AddMedication2(),
                  //     ),
                  //   );
                  // }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMedication2(),
                    ),
                  );
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
