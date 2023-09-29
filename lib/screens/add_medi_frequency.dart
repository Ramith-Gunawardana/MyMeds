import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
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

  bool showFrequencySection = true;
  bool showDaysSection = false;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Frequency',
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
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _clearSelectionAndResetControllers();
                      Navigator.pop(context);
                      //should cancel the changes and controller should be empty
                      _medicationFrequencyController.clear();
                      //printing the output in Debug Console
                      print(_medicationFrequencyController.text);
                    },
                    style: ElevatedButton.styleFrom(),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _showSnackBar('Saved Successfully');
                        Navigator.pop(context);
                      }
                      if (_medicationFrequencyController.text.isEmpty) {
                        _showSnackBar('Please select a frequency');
                      }
                      //printing the output in Debug Console
                      print(_medicationFrequencyController.text);
                    },
                    child: const Text('Done'),
                  ),
                ],
              ),
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
                  });
                },
                selectedColor: Theme.of(context).colorScheme.secondary,
                unSelectedBorderColor: Theme.of(context).colorScheme.secondary,
                selectedBorderColor: Theme.of(context).colorScheme.secondary,
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
                MultiSelectDropDown(
                  onOptionSelected: (List<ValueItem> selectedOptions) {
                    if (selectedOptions.isNotEmpty) {
                      // Assuming you want to concatenate selected options into a single string
                      String selectedValue = selectedOptions
                          .map((option) => option.value)
                          .join(', ');
                      _medicationFrequencyController.text = selectedValue;
                    } else {
                      // Handle the case where no options are selected
                      _medicationFrequencyController.text = '';
                    }
                  },
                  options: const <ValueItem>[
                    ValueItem(label: 'Every Day', value: '1'),
                    ValueItem(label: 'Every 2 Days', value: '2'),
                    ValueItem(label: 'Every 3 Days', value: '3'),
                    ValueItem(label: 'Every 4 Days', value: '4'),
                    ValueItem(label: 'Every 5 Days', value: '5'),
                    ValueItem(label: 'Every 6 Days', value: '6'),
                    ValueItem(label: 'Every Week (7 Days)', value: '7'),
                    ValueItem(label: 'Every 2 Weeks (14 Days)', value: '14'),
                    ValueItem(label: 'Every 3 Weeks (21 Days)', value: '21'),
                    ValueItem(label: 'Every Month (30 Days)', value: '30'),
                    ValueItem(label: 'Every 2 Months (60 Days)', value: '60'),
                    ValueItem(label: 'Every 3 Months (90 Days)', value: '90'),
                  ],
                  selectionType: SelectionType.single,
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  dropdownHeight: 300,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                  //default selected option should be everyday
                  selectedOptions: const <ValueItem>[
                    ValueItem(label: 'Every Day', value: '1'),
                  ],
                ),
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
                  onChanged: (int day) {
                    setState(() {
                      values[day % 7] = !values[day % 7];
                    });
                  },
                  values: values,
                ),
              ],
            ],
          ),
        ),
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
