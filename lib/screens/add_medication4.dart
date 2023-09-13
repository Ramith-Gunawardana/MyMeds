import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymeds_app/components/category_model.dart';
import 'package:mymeds_app/components/controller_data.dart';

class AddMedication4 extends StatefulWidget {
  List<CategoryModel> categories = CategoryModel.getCategories();

  @override
  _AddMedication4State createState() => _AddMedication4State();
}

class _AddMedication4State extends State<AddMedication4> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  TextEditingController medname =
      MedicationControllerData().medicationNameController;
  TextEditingController category =
      MedicationControllerData().medicationTypeController;
  TextEditingController strength =
      MedicationControllerData().medicationStrengthValueController;
  TextEditingController strength_unit =
      MedicationControllerData().medicationStrengthController;

  TextEditingController medcount =
      MedicationControllerData().medicationDosageValueController;
  // TextEditingController _medicationDosageController =
  //     MedicationControllerData().medicationDosageController;
  TextEditingController total_med =
      MedicationControllerData().medicationCountController;
  TextEditingController user_note =
      MedicationControllerData().medicationNoteController;

  TextEditingController times =
      MedicationControllerData().medicationDosageValueController;
  TextEditingController intake =
      MedicationControllerData().medicationNumberOfTimesController;
  TextEditingController start_date =
      MedicationControllerData().medicationStartingDateController;
  TextEditingController end_date =
      MedicationControllerData().medicationEndingDateController;

  int _selectedCategoryIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SUMMERY',
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
              Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Align children vertically in the center
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 6),
                          Image.asset(
                            'lib/assets/icons/summerymedicine.gif',
                            width: 100,
                            height: 50,
                            fit: BoxFit.fitHeight,
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(width: 20),
                  ],
                ),
              ),
              //horizontal line
              Container(
                height: 1,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MEDICINE DETAILS',
                    style: TextStyle(
                        color: Colors.tealAccent[700],
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              //horizontal line
              Container(
                height: 2,
                color: Colors.grey,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 50),
                    child: Text(
                      'Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      medname.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 25),
                    child: Text(
                      'Category',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      category.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: (strength
                    .text.isNotEmpty), // Check if both texts are not empty
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 30),
                      child: Text(
                        'Strength',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        strength.text + ' ' + strength_unit.text,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              //horizontal line
              Container(
                height: 1,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MEDICATION INTAKE',
                    style: TextStyle(
                        color: Colors.tealAccent[700],
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              //horizontal line
              Container(
                height: 2,
                color: Colors.grey,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 30),
                    child: Text(
                      'Dosage per Intake',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      medcount.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              //This is optional
              Visibility(
                visible: total_med.text.isNotEmpty, // Set your condition here
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 20),
                      child: Text(
                        'Available Pill Count',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        total_med.text,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              //horizontal line
              Container(
                height: 1,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FREQUENCY',
                    style: TextStyle(
                        color: Colors.tealAccent[700],
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              //horizontal line
              Container(
                height: 2,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 10),
                    child: Text(
                      '${intake.text} times of the Day',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      times.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 10),
                    child: Text(
                      'Starting Date',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 50),
                    child: Text(
                      start_date.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              //This is optional
              Visibility(
                visible:
                    end_date.text.isNotEmpty, // Check if the data is not empty
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        'Ending Date',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 50),
                      child: Text(
                        end_date.text,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),
              //horoizontal line
              Container(
                height: 1,
                color: Colors.grey,
              ),

              //This is optional
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Notes',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      user_note.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  //   builder: (context) => AddMedication(),
                  // ),
                  // );
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
