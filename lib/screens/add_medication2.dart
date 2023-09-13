import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:mymeds_app/components/category_model.dart';
import 'package:mymeds_app/components/controller_data.dart';
import 'package:mymeds_app/components/text_field.dart';
// import 'package:show_time_picker/show_time_picker.dart';
import 'package:mymeds_app/screens/add_medication3.dart';

class AddMedication2 extends StatefulWidget {
  List<CategoryModel> categories = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
  }

  @override
  _AddMedication2State createState() => _AddMedication2State();
}

bool isPillCountRequired = false;

class _AddMedication2State extends State<AddMedication2> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _medicationDosageValueController =
      MedicationControllerData().medicationDosageValueController;
  TextEditingController _medicationDosageController =
      MedicationControllerData().medicationDosageController;
  TextEditingController _medicationCountController =
      MedicationControllerData().medicationCountController;
  TextEditingController _medicationNoteController =
      MedicationControllerData().medicationNoteController;

  @override
  void initState() {
    super.initState();
    widget._getInitialInfo();
  }

  @override
  Widget build(BuildContext context) {
    widget._getInitialInfo();
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
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  'Dosage per Intake',
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
                      controller: _medicationDosageValueController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select the dosage per intake';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 7, 82, 96),
                      decoration: InputDecoration(
                        hintText: '1',
                        labelText: 'Count',
                        labelStyle: GoogleFonts.roboto(
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
                    child: MultiSelectDropDown(
                      onOptionSelected: (List<ValueItem> selectedOptions) {
                        if (selectedOptions.isNotEmpty) {
                          // Assuming you want to concatenate selected options into a single string
                          String selectedValue = selectedOptions
                              .map((option) => option.value)
                              .join(', ');
                          _medicationDosageController.text = selectedValue;
                        } else {
                          // Handle the case where no options are selected
                          _medicationDosageController.text = '';
                        }
                      },
                      options: const <ValueItem>[
                        ValueItem(label: 'pill', value: 'pill'),
                        ValueItem(label: 'tsp', value: 'tsp'),
                        ValueItem(label: 'tbsp', value: 'tbsp'),
                        ValueItem(label: 'cup', value: 'cup'),
                        ValueItem(label: 'mg', value: 'mg'),
                        ValueItem(label: 'mcg', value: 'mcg'),
                        ValueItem(label: 'g', value: 'g'),
                        ValueItem(label: 'ml', value: 'ml'),
                        ValueItem(label: '%', value: '%'),
                        ValueItem(label: 'IU', value: 'IU'),
                        ValueItem(label: 'oz', value: 'oz'),
                        ValueItem(label: 'pt', value: 'pt'),
                        ValueItem(label: 'qt', value: 'qt'),
                        ValueItem(label: 'gal', value: 'gal'),
                        ValueItem(label: 'lb', value: 'lb'),
                        ValueItem(label: 'mg/mL', value: 'mg/mL'),
                      ],
                      selectionType: SelectionType.single,
                      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                      dropdownHeight: 400,
                      optionTextStyle: const TextStyle(fontSize: 16),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                      backgroundColor: Colors.transparent,
                      focusedBorderWidth: 2,
                      inputDecoration: BoxDecoration(
                        color: const Color.fromARGB(255, 219, 228, 231),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorderColor: const Color.fromARGB(255, 7, 82, 96),
                      padding: const EdgeInsets.all(22),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft, // Align to the left
                      child: Checkbox(
                        value: isPillCountRequired,
                        onChanged: (newValue) {
                          setState(() {
                            isPillCountRequired = newValue!;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Available Pill Count (Optional)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isPillCountRequired)
                Text_Field(
                  label: 'Total Pill Count',
                  hint: '30',
                  isPassword: false,
                  keyboard: TextInputType.number,
                  txtEditController: _medicationCountController,
                ),
              SizedBox(height: 24),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 3,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  'Takes Notes If Needed',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _medicationNoteController,
                decoration: InputDecoration(
                  labelText: '   Medication Notes',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                ),
                maxLines:
                    null, // Set this to null to allow unlimited vertical flow
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMedication3(),
                    ),
                  );
                  //Print in Debug Console
                  print(_medicationDosageValueController.text);
                  print(_medicationDosageController.text);
                  print(_medicationCountController.text);
                  print(_medicationNoteController.text);
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
