import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/components/controller_data.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AddMediFrequency extends StatefulWidget {
  const AddMediFrequency({Key? key}) : super(key: key);

  @override
  _AddMediFrequencyState createState() => _AddMediFrequencyState();
}

List<bool> values = List.filled(7, false);

class _AddMediFrequencyState extends State<AddMediFrequency> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _medicationFrequencyController =
      MedicationControllerData().medicationFrequencyController;

  final TextEditingController _medicationFrequency_isSpecificDays_Controller =
      MedicationControllerData().medicationFrequency_isSpecificDays_Controller;
  final TextEditingController _medicationFrequency_weekday_Controller =
      MedicationControllerData().medicationFrequency_weekday_Controller;
  bool showFrequencySection = true;
  bool showDaysSection = false;

  List<String> specificDays = [];
  List<int> weekdays = [];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 7, 83, 96),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool isDaySelected() {
    for (var element in values) {
      if (element == true) {
        return true;
      }
    }
    return false;
  }

  void addToSpecificDays() {
    for (int i = 0; i < values.length; i++) {
      print(values[i]);
      if (values[i] == true) {
        switch (i) {
          case 0:
            specificDays.add('Sun');
            weekdays.add(DateTime.sunday);
            break;
          case 1:
            specificDays.add('Mon');
            weekdays.add(DateTime.monday);
            break;
          case 2:
            specificDays.add('Tue');
            weekdays.add(DateTime.tuesday);
            break;
          case 3:
            specificDays.add('Wed');
            weekdays.add(DateTime.wednesday);
            break;
          case 4:
            specificDays.add('Thu');
            weekdays.add(DateTime.thursday);
            break;
          case 5:
            specificDays.add('Fri');
            weekdays.add(DateTime.friday);
            break;
          case 6:
            specificDays.add('Sat');
            weekdays.add(DateTime.saturday);
            break;
          default:
            break;
        }
      }
    }
    print(specificDays);
  }

  void addFrequency() {
    if (showFrequencySection && _medicationFrequencyController.text.isEmpty) {
      _showSnackBar('Select interval');
    } else if (showDaysSection && !isDaySelected()) {
      _showSnackBar('Select day(s)');
    } else {
      if (showFrequencySection) {
        _medicationFrequency_isSpecificDays_Controller.text = "false";
        Navigator.pop(context, _medicationFrequencyController.text);
      } else {
        addToSpecificDays();
        _medicationFrequency_isSpecificDays_Controller.text = "true";
        _medicationFrequency_weekday_Controller.text =
            weekdays.toString().replaceAll('[', '').replaceAll(']', '');
        Navigator.pop(context,
            specificDays.toString().replaceAll('[', '').replaceAll(']', ''));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: <Widget>[
          Column(
            children: [
              CustomRadioButton(
                elevation: 4,
                unSelectedColor: Theme.of(context).canvasColor,
                buttonLables: const [
                  'At Regular Intervals',
                  'On Specific Days of the Week',
                ],
                buttonValues: const [
                  "At Regular Intervals",
                  "On Specific Days of the Week",
                ],
                buttonTextStyle: const ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.black,
                    textStyle: TextStyle(fontSize: 16)),
                radioButtonValue: (value) {
                  setState(() {
                    showFrequencySection = value == "At Regular Intervals";
                    showDaysSection = value == "On Specific Days of the Week";
                    //clear both input fields when click any of the buttons
                    _clearSelectionAndResetControllers();
                    _medicationFrequencyController.clear();
                  });
                },
                defaultSelected: "At Regular Intervals",
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedBorderColor: Theme.of(context).colorScheme.primary,
                selectedBorderColor: Theme.of(context).colorScheme.primary,
                padding: 5,
                height: 50,
                width: 150,
                enableShape: true,
                enableButtonWrap: true,
                wrapAlignment: WrapAlignment.center,
                horizontal: true,
              ),
              if (showFrequencySection) ...[
                const SizedBox(height: 16),
                const Text(
                  'Choose the Interval',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 16, 15, 15),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownMenu(
                  controller: _medicationFrequencyController,
                  textStyle: GoogleFonts.roboto(
                    height: 2,
                    color: const Color.fromARGB(255, 16, 15, 15),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
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
                    DropdownMenuEntry(label: 'Every Day', value: '1'),
                    DropdownMenuEntry(label: 'Every 2 Days', value: '2'),
                    DropdownMenuEntry(label: 'Every 3 Days', value: '3'),
                    DropdownMenuEntry(label: 'Every 4 Days', value: '4'),
                    DropdownMenuEntry(label: 'Every 5 Days', value: '5'),
                    DropdownMenuEntry(label: 'Every 6 Days', value: '6'),
                    DropdownMenuEntry(label: 'Every Week (7 Days)', value: '7'),
                    DropdownMenuEntry(
                        label: 'Every 2 Weeks (14 Days)', value: '14'),
                    DropdownMenuEntry(
                        label: 'Every 3 Weeks (21 Days)', value: '21'),
                    DropdownMenuEntry(
                        label: 'Every Month (30 Days)', value: '30'),
                    DropdownMenuEntry(
                        label: 'Every 2 Months (60 Days)', value: '60'),
                    DropdownMenuEntry(
                        label: 'Every 3 Months (90 Days)', value: '90'),
                  ],
                  menuHeight: 200,
                  label: const Text('Frequency'),
                ),
                // MultiSelectDropDown(
                //   onOptionSelected: (List<ValueItem> selectedOptions) {
                //     if (selectedOptions.isNotEmpty) {
                //       // Assuming you want to concatenate selected options into a single string
                //       String selectedValue = selectedOptions
                //           .map((option) => option.value)
                //           .join(', ');
                //       _medicationFrequencyController.text = selectedValue;
                //     } else {
                //       // Handle the case where no options are selected
                //       _medicationFrequencyController.text = '';
                //     }
                //   },
                //   options: const <ValueItem>[
                //     ValueItem(label: 'Every Day', value: '1'),
                //     ValueItem(label: 'Every 2 Days', value: '2'),
                //     ValueItem(label: 'Every 3 Days', value: '3'),
                //     ValueItem(label: 'Every 4 Days', value: '4'),
                //     ValueItem(label: 'Every 5 Days', value: '5'),
                //     ValueItem(label: 'Every 6 Days', value: '6'),
                //     ValueItem(label: 'Every Week (7 Days)', value: '7'),
                //     ValueItem(label: 'Every 2 Weeks (14 Days)', value: '14'),
                //     ValueItem(label: 'Every 3 Weeks (21 Days)', value: '21'),
                //     ValueItem(label: 'Every Month (30 Days)', value: '30'),
                //     ValueItem(label: 'Every 2 Months (60 Days)', value: '60'),
                //     ValueItem(label: 'Every 3 Months (90 Days)', value: '90'),
                //   ],
                //   selectionType: SelectionType.single,
                //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                //   dropdownHeight: 300,
                //   optionTextStyle: const TextStyle(fontSize: 16),
                //   selectedOptionIcon: const Icon(Icons.check_circle),
                //   //default selected option should be everyday
                //   selectedOptions: const <ValueItem>[
                //     ValueItem(label: 'Every Day', value: '1'),
                //   ],
                // ),
              ],
              if (showDaysSection) ...[
                const SizedBox(height: 16),
                const Text(
                  'Select the Days',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 16, 15, 15),
                  ),
                ),
                const SizedBox(height: 16),
                WeekdaySelector(
                  firstDayOfWeek: 7,
                  shortWeekdays: const [
                    'Sun',
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat'
                  ],
                  onChanged: (int day) {
                    setState(() {
                      values[day % 7] = !values[day % 7];
                    });
                  },
                  values: values,
                ),
              ],
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _clearSelectionAndResetControllers();
                  //     Navigator.pop(context);
                  //     //should cancel the changes and controller should be empty
                  //     _medicationFrequencyController.clear();
                  //     //printing the output in Debug Console
                  //     print(_medicationFrequencyController.text);
                  //   },
                  //   style: ElevatedButton.styleFrom(),
                  //   child: const Text('Cancel'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     if (_formKey.currentState!.validate()) {
                  //       _showSnackBar('Saved Successfully');
                  //       Navigator.pop(context);
                  //     }
                  //     if (_medicationFrequencyController.text.isEmpty) {
                  //       _showSnackBar('Please select a frequency');
                  //     }
                  //     //printing the output in Debug Console
                  //     print(_medicationFrequencyController.text);
                  //   },
                  //   child: const Text('Done'),
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    child: FilledButton(
                      onPressed: () {
                        _clearSelectionAndResetControllers();
                        _medicationFrequencyController.clear();
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 217, 237, 239)),
                        foregroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(7, 82, 96, 1)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    child: FilledButton(
                      onPressed: addFrequency,
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
                        'Done',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _clearSelectionAndResetControllers() {
    setState(() {
      // Clear selected states
      values = List.filled(7, false);

      // Reset controllers to default values
      // _medicationFrequencyController.clear();
    });
  }
}
