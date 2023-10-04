import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/components/category_model.dart';
import 'package:mymeds_app/components/controller_data.dart';
import 'package:mymeds_app/components/text_field.dart';
import 'package:mymeds_app/screens/add_medication2.dart';

class AddMedication1 extends StatefulWidget {
  List<CategoryModel> categories = CategoryModel.getCategories();

  AddMedication1({super.key});

  @override
  _AddMedication1State createState() => _AddMedication1State();
}

class _AddMedication1State extends State<AddMedication1> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _medicationNameController =
      MedicationControllerData().medicationNameController;
  final TextEditingController _medicationTypeController =
      MedicationControllerData().medicationTypeController;
  final TextEditingController _medicationStrengthValueController =
      MedicationControllerData().medicationStrengthValueController;
  final TextEditingController _medicationStrengthController =
      MedicationControllerData().medicationStrengthController;

  late FocusNode focusNode_medName;
  late FocusNode focusNode_medStrengthValue;

  int _selectedCategoryIndex = -1;

  void _openImagePicker() {
    // Implement your image picker logic here
    // This function will be called when the image is clicked
  }
  @override
  void initState() {
    super.initState();
    focusNode_medName = FocusNode();
    focusNode_medStrengthValue = FocusNode();
  }

  // for memory mgt
  // @override
  // void dispose() {
  //   _medicationNameController.dispose();
  //   _medicationTypeController.dispose();
  //   _medicationStrengthValueController.dispose();
  //   _medicationStrengthController.dispose();
  //   focusNode_medName.dispose();
  //   focusNode_medStrength.dispose();
  //   focusNode_medStrengthValue.dispose();
  //   focusNode_medType.dispose();
  //   super.dispose();
  // }

  void goToNextPage() {
    if (_medicationNameController.text.isEmpty) {
      focusNode_medName.requestFocus();
    } else if (_selectedCategoryIndex < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 7, 83, 96),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text(
            'Please select the medication category',
          ),
        ),
      );
    } else {
      if (_medicationStrengthValueController.text.isNotEmpty &&
          _selectedCategoryIndex < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 7, 83, 96),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(
              'Please select the strength value type',
            ),
          ),
        );
      } else {
        //print all controller values
        print(_medicationNameController.text);
        print(_medicationTypeController.text);
        print(_medicationStrengthValueController.text +
            _medicationStrengthController.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMedication2(),
          ),
        );
      }
    }
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
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Align children vertically in the center
                children: [
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         'Add each medicine separately',
                  //         style: GoogleFonts.roboto(
                  //             fontSize: 11, color: Colors.teal),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //       SizedBox(height: 6),
                  //       Image.asset(
                  //         'lib/assets/icons/medicine.gif',
                  //         width: 30,
                  //         height: 30,
                  //         fit: BoxFit.fitHeight,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: _openImagePicker,
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 40, right: 40, top: 10, bottom: 10),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add_a_photo_outlined, size: 50),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //medication name
              const Text(
                'Medication Name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Text_Field(
                label: 'Medication Name',
                hint: 'Vitamic C',
                isPassword: false,
                keyboard: TextInputType.text,
                txtEditController: _medicationNameController,
                focusNode: focusNode_medName,
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                height: 2,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 20),
              const Text(
                'Category',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: widget.categories.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 0, right: 20),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 16), // Adjust the right padding for space
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (_selectedCategoryIndex == index) {
                              // If the same category is tapped again, deselect it
                              // _selectedCategoryIndex = -1;
                              // _medicationTypeController.text = '';
                            } else {
                              // Deselect the previously selected category
                              if (_selectedCategoryIndex != -1) {
                                widget.categories[_selectedCategoryIndex]
                                        .boxColor =
                                    const Color.fromARGB(255, 158, 158, 158);
                                widget.categories[_selectedCategoryIndex]
                                    .isSelected = false;
                              }

                              // Select the tapped category
                              _selectedCategoryIndex = index;
                              _medicationTypeController.text =
                                  widget.categories[index].name;
                              widget.categories[index].boxColor =
                                  const Color.fromARGB(255, 7, 82, 96)
                                      .withOpacity(0.3);
                              widget.categories[index].isSelected = true;

                              print(_medicationTypeController.text);
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: widget.categories[index].boxColor
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    widget.categories[index].iconPath,
                                  ),
                                ),
                              ),
                              Text(
                                widget.categories[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                height: 2,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 20),
              const Text(
                'Strength (Optional)',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text_Field(
                  //   label: 'Strength Value',
                  //   hint: '100',
                  //   isPassword: false,
                  //   keyboard: TextInputType.text,
                  //   txtEditController: _medicationStrengthValueController,
                  //   focusNode: focusNode_medStrengthValue,
                  // ),
                  Expanded(
                    child: TextField(
                      controller: _medicationStrengthValueController,
                      focusNode: focusNode_medStrengthValue,
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 7, 82, 96),
                      style: const TextStyle(
                        height: 2,
                      ),
                      decoration: InputDecoration(
                        hintText: '100',
                        labelText: 'Strength Value',
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
                  const SizedBox(width: 10),
                  //strength type
                  DropdownMenu(
                    controller: _medicationStrengthController,
                    textStyle: GoogleFonts.roboto(
                      height: 2,
                      color: const Color.fromARGB(255, 16, 15, 15),
                    ),
                    width: MediaQuery.of(context).size.width * 0.43,
                    menuStyle: const MenuStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    inputDecorationTheme: const InputDecorationTheme(
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 7, 82, 96),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
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
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(label: 'mg', value: 'mg'),
                      DropdownMenuEntry(label: 'mcg', value: 'mcg'),
                      DropdownMenuEntry(label: 'g', value: 'g'),
                      DropdownMenuEntry(label: 'ml', value: 'ml'),
                      DropdownMenuEntry(label: 'tsp', value: 'tsp'),
                      DropdownMenuEntry(label: 'tbsp', value: 'tbsp'),
                      DropdownMenuEntry(label: '%', value: '%'),
                      DropdownMenuEntry(label: 'cup', value: 'cup'),
                      DropdownMenuEntry(label: 'IU', value: 'IU'),
                      DropdownMenuEntry(label: 'oz', value: 'oz'),
                      DropdownMenuEntry(label: 'pt', value: 'pt'),
                      DropdownMenuEntry(label: 'qt', value: 'qt'),
                      DropdownMenuEntry(label: 'gal', value: 'gal'),
                      DropdownMenuEntry(label: 'lb', value: 'lb'),
                      DropdownMenuEntry(label: 'mg/mL', value: 'mg/mL'),
                    ],
                    menuHeight: 200,
                    label: const Text('Type'),
                  ),

                  // Expanded(
                  //   child: MultiSelectDropDown(
                  //     onOptionSelected: (List<ValueItem> selectedOptions) {
                  //       if (selectedOptions.isNotEmpty) {
                  //         // Assuming you want to concatenate selected options into a single string
                  //         String selectedValue = selectedOptions
                  //             .map((option) => option.value)
                  //             .join(', ');
                  //         _medicationStrengthController.text = selectedValue;
                  //       } else {
                  //         // Handle the case where no options are selected
                  //         _medicationStrengthController.text = '';
                  //       }
                  //     },
                  //     options: const <ValueItem>[
                  //       ValueItem(label: 'mg', value: 'mg'),
                  //       ValueItem(label: 'mcg', value: 'mcg'),
                  //       ValueItem(label: 'g', value: 'g'),
                  //       ValueItem(label: 'ml', value: 'ml'),
                  //       ValueItem(label: 'tsp', value: 'tsp'),
                  //       ValueItem(label: 'tbsp', value: 'tbsp'),
                  //       ValueItem(label: '%', value: '%'),
                  //       ValueItem(label: 'cup', value: 'cup'),
                  //       ValueItem(label: 'IU', value: 'IU'),
                  //       ValueItem(label: 'oz', value: 'oz'),
                  //       ValueItem(label: 'pt', value: 'pt'),
                  //       ValueItem(label: 'qt', value: 'qt'),
                  //       ValueItem(label: 'gal', value: 'gal'),
                  //       ValueItem(label: 'lb', value: 'lb'),
                  //       ValueItem(label: 'mg/mL', value: 'mg/mL'),
                  //     ],
                  //     selectionType: SelectionType.single,
                  //     chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  //     dropdownHeight: 200,
                  //     optionTextStyle: const TextStyle(fontSize: 16),
                  //     selectedOptionIcon: const Icon(Icons.check_circle),
                  //     backgroundColor: Colors.transparent,
                  //     focusedBorderWidth: 2,
                  //     inputDecoration: BoxDecoration(
                  //       color: const Color.fromARGB(255, 219, 228, 231),
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     focusedBorderColor: const Color.fromARGB(255, 7, 82, 96),
                  //     padding: const EdgeInsets.all(22),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: goToNextPage,
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
                    'Next',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     goToNextPage();
              //     //print all controller values
              //     print(_medicationNameController.text);
              //     print(_medicationTypeController.text);
              //     print(_medicationStrengthValueController.text +
              //         _medicationStrengthController.text);
              //   },
              //   child: const Text('Next'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
