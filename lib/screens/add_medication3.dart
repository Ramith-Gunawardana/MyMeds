import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/components/controller_data.dart';
import 'package:mymeds_app/screens/add_medi_frequency.dart';
import 'package:mymeds_app/screens/add_medication4.dart';

class AddMedication3 extends StatefulWidget {
  const AddMedication3({Key? key}) : super(key: key);

  @override
  _AddMedication3State createState() => _AddMedication3State();
}

class _AddMedication3State extends State<AddMedication3> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  var _startingDateController = TextEditingController(
    text: DateTime.now().toString().substring(0, 10),
  );

  // var _medicationTimeOfDayController = TextEditingController();
  // final _medicationNumberOfTimesController = TextEditingController();
  // final _medicationStartingDateController = TextEditingController();
  // final _medicationEndingDateController = TextEditingController();

  TextEditingController _medicationTimeOfDayController =
      MedicationControllerData().medicationDosageValueController;
  TextEditingController _medicationNumberOfTimesController =
      MedicationControllerData().medicationNumberOfTimesController;
  TextEditingController _medicationStartingDateController =
      MedicationControllerData().medicationStartingDateController;
  TextEditingController _medicationEndingDateController =
      MedicationControllerData().medicationEndingDateController;

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  var endDate;

  var startDate;

  List<String> selectedTimes = [];

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
      _medicationNumberOfTimesController.text = selectedTimes.length.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sort the selected times list
    selectedTimes.sort((a, b) => _compareTimes(a, b));

    // Get the current date for date pickers
    final DateTime now = DateTime.now();
    final DateTime firstStartDate =
        now.subtract(Duration(days: 1)); // To include today
    final DateTime lastStartDate = DateTime(2101);

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
              SizedBox(height: 24),
              // This is a title
              Text(
                'Times of the Day',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 16),
              // Time input field with the ability to add times directly
              Row(
                children: [
                  Expanded(
                    child: TextField(
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
                            is24HrFormat: true,
                            blurredBackground: true,
                            onChangeDateTime: (DateTime dateTime) {
                              setState(() {
                                _medicationTimeOfDayController =
                                    TextEditingController(
                                  text: TimeOfDay.fromDateTime(dateTime)
                                      .format(context),
                                );
                              });
                              print(dateTime);
                            },
                          ),
                        );
                      },
                      controller: _medicationTimeOfDayController,
                      readOnly: true,
                      style: GoogleFonts.roboto(
                        height: 2,
                        color: const Color.fromARGB(255, 16, 15, 15),
                      ),
                      cursorColor: const Color.fromARGB(255, 7, 82, 96),
                      decoration: InputDecoration(
                        hintText: 'Select the Time and add it',
                        labelText: 'Medication Times',
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
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      String selectedTime = _medicationTimeOfDayController.text;
                      if (selectedTime.isNotEmpty &&
                          !selectedTimes.contains(selectedTime)) {
                        setState(() {
                          selectedTimes.add(selectedTime);
                          _medicationTimeOfDayController.clear();
                        });
                      } else {
                        // Show a snackbar if the same time is added
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('This time is already added.'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        // Show another snackbar after a brief delay
                        Future.delayed(Duration(seconds: 2), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Same Time cannot be added twice.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 16),
              // Display the count of selected times
              Text(
                  'Number of Medication Times per day: ${selectedTimes.length}'),

              SizedBox(height: 16),
              // Display the selected times with delete buttons
              Column(
                children: selectedTimes
                    .asMap()
                    .entries
                    .map(
                      (entry) => ListTile(
                        title: Text(entry.value),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              selectedTimes.removeAt(entry.key);
                            });
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 36),
              //Horizontal line
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 3,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: 16),
              Text(
                'When will you take this?',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  // navigate to add_medi_frequency.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMediFrequency(),
                    ),
                  );
                },
                child: Text('Add Medication Frequency'),
              ),

              SizedBox(height: 16),
              TextField(
                onTap: () async {
                  final DateTime? pickedStartDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: firstStartDate,
                    lastDate: lastStartDate,
                  );
                  if (pickedStartDate != null && pickedStartDate != startDate)
                    setState(() {
                      startDate = pickedStartDate;
                      _startingDateController = TextEditingController(
                          text: startDate.toString().substring(0, 10));
                    });
                },
                controller: _startingDateController,
                readOnly: true,
                style: GoogleFonts.roboto(
                  height: 2,
                  color: const Color.fromARGB(255, 16, 15, 15),
                ),
                cursorColor: const Color.fromARGB(255, 7, 82, 96),
                decoration: InputDecoration(
                  hintText: 'Select the Date',
                  labelText: 'Starting Date',
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

              SizedBox(height: 16),
              // Checkbox to make ending date optional
              Row(
                children: [
                  Checkbox(
                    value: endDate != null,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          // Enable the ending date
                          endDate = DateTime.now();
                        } else {
                          // Disable the ending date
                          endDate = null;
                        }
                        _startingDateController.clear();
                      });
                    },
                  ),
                  Text('Ending Date (Optional)'),
                ],
              ),

              // Ending date picker (conditionally shown)
              if (endDate != null)
                TextField(
                  onTap: () async {
                    final DateTime? pickedEndDate = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: firstStartDate,
                      lastDate: lastStartDate,
                    );
                    if (pickedEndDate != null && pickedEndDate != endDate)
                      setState(() {
                        endDate = pickedEndDate;
                        _startingDateController = TextEditingController(
                            text: endDate.toString().substring(0, 10));
                      });
                  },
                  controller: _startingDateController,
                  readOnly: true,
                  style: GoogleFonts.roboto(
                    height: 2,
                    color: const Color.fromARGB(255, 16, 15, 15),
                  ),
                  cursorColor: const Color.fromARGB(255, 7, 82, 96),
                  decoration: InputDecoration(
                    hintText: 'Select the Date',
                    labelText: 'Ending Date',
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
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMedication4(),
                    ),
                  );
                  //Print in Debug Console
                  print(_medicationTimeOfDayController.text);
                  print(_medicationStartingDateController.text);
                  print(_medicationEndingDateController.text);
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

int _compareTimes(String timeA, String timeB) {
  // Helper function to compare two time strings
  // Example format: "01:30 PM"

  // Split the time string and extract hours and minutes
  final List<String> partsA = timeA.split(' ');
  final List<String> partsB = timeB.split(' ');

  final int hourA = int.parse(partsA[0].split(':')[0]);
  final int minuteA = int.parse(partsA[0].split(':')[1]);
  final String periodA = partsA[1];

  final int hourB = int.parse(partsB[0].split(':')[0]);
  final int minuteB = int.parse(partsB[0].split(':')[1]);
  final String periodB = partsB[1];

  // Compare AM and PM times
  if (periodA == 'AM' && periodB == 'PM') {
    return -1;
  } else if (periodA == 'PM' && periodB == 'AM') {
    return 1;
  }

  // Compare hours
  if (hourA < hourB) {
    return -1;
  } else if (hourA > hourB) {
    return 1;
  }

  // Compare minutes
  if (minuteA < minuteB) {
    return -1;
  } else if (minuteA > minuteB) {
    return 1;
  }

  return 0; // Times are equal
}
