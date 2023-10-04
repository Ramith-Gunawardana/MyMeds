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

  final TextEditingController _medicationTimeOfDayController =
      MedicationControllerData().medicationDosageValueController;
  final TextEditingController _medicationNumberOfTimesController =
      MedicationControllerData().medicationNumberOfTimesController;
  final TextEditingController _medicationStartingDateController =
      MedicationControllerData().medicationStartingDateController;
  final TextEditingController _medicationEndingDateController =
      MedicationControllerData().medicationEndingDateController;

  bool iosStyle = true;

  var endDate;

  var startDate;

  List<String?> selectedTimes = [];

  // void onTimeChanged(Time newTime) {
  //   setState(() {
  //     _time = newTime;
  //     _medicationNumberOfTimesController.text = selectedTimes.length.toString();
  //   });
  // }

  void addFirstTime() {
    if (selectedTimes.isEmpty) {
      String formattedTime = formatTime(TimeOfDay.fromDateTime(DateTime.now()));
      setState(() {
        selectedTimes.add(formattedTime);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      addFirstTime();
    });
  }

  String formatTime(TimeOfDay timeOfDay) {
    int hour = timeOfDay.hour;
    int minute = timeOfDay.minute;

    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = minute.toString().padLeft(2, '0');

    return '$hourStr:$minuteStr';
  }

  @override
  Widget build(BuildContext context) {
    // Sort the selected times list
    // selectedTimes.sort((a, b) => _compareTimes(a, b));

    // Get the current date for date pickers
    final DateTime now = DateTime.now();
    final DateTime firstStartDate =
        now.subtract(const Duration(days: 1)); // To include today
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
        elevation: 5,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: ListView(
            children: [
              // This is a title
              Text(
                'Medication Times: ${selectedTimes.length} time(s) per day',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              // Time input field with the ability to add times directly
              // Row(
              //   children: [
              //     Expanded(
              //       child: TextField(
              //         onTap: () {
              //           Navigator.of(context).push(
              //             showPicker(
              //               context: context,
              //               value: _time,
              //               sunrise:
              //                   const TimeOfDay(hour: 6, minute: 0), // optional
              //               sunset: const TimeOfDay(
              //                   hour: 18, minute: 0), // optional
              //               duskSpanInMinutes: 120, // optional
              //               onChange: onTimeChanged,
              //               iosStylePicker: iosStyle,
              //               is24HrFormat: true,
              //               onChangeDateTime: (DateTime dateTime) {
              //                 setState(() {
              //                   _medicationTimeOfDayController =
              //                       TextEditingController(
              //                     text: TimeOfDay.fromDateTime(dateTime)
              //                         .format(context),
              //                   );
              //                 });
              //                 print(dateTime);
              //               },
              //             ),
              //           );
              //         },
              //         controller: _medicationTimeOfDayController,
              //         readOnly: true,
              //         style: GoogleFonts.roboto(
              //           height: 2,
              //           color: const Color.fromARGB(255, 16, 15, 15),
              //         ),
              //         cursorColor: const Color.fromARGB(255, 7, 82, 96),
              //         decoration: InputDecoration(
              //           hintText: 'Select the Time and add it',
              //           labelText: 'Medication Times',
              //           labelStyle: GoogleFonts.roboto(
              //             color: const Color.fromARGB(255, 16, 15, 15),
              //           ),
              //           filled: true,
              //           floatingLabelBehavior: FloatingLabelBehavior.auto,
              //           focusedBorder: const OutlineInputBorder(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(20),
              //             ),
              //             borderSide: BorderSide(
              //               color: Color.fromARGB(255, 7, 82, 96),
              //             ),
              //           ),
              //           enabledBorder: const OutlineInputBorder(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(20),
              //             ),
              //             borderSide: BorderSide(color: Colors.transparent),
              //           ),
              //         ),
              //       ),
              //     ),
              //     IconButton(
              //       icon: const Icon(Icons.add),
              //       onPressed: () {
              //         String selectedTime = _medicationTimeOfDayController.text;
              //         if (selectedTime.isNotEmpty &&
              //             !selectedTimes.contains(selectedTime)) {
              //           setState(() {
              //             selectedTimes.add(selectedTime);
              //             _medicationTimeOfDayController.clear();
              //           });
              //         } else {
              //           // Show a snackbar if the same time is added
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             const SnackBar(
              //               content: Text('This time is already added.'),
              //               duration: Duration(seconds: 2),
              //             ),
              //           );

              //           // Show another snackbar after a brief delay
              //           Future.delayed(const Duration(seconds: 2), () {
              //             ScaffoldMessenger.of(context).showSnackBar(
              //               const SnackBar(
              //                 content: Text('Same Time cannot be added twice.'),
              //                 duration: Duration(seconds: 2),
              //               ),
              //             );
              //           });
              //         }
              //       },
              //     ),
              //   ],
              // ),

              // Display the count of selected times
              // Text('Number of Medication Times per day: ${selectedTimes.length}'),

              // Display the selected times with delete buttons
              Column(
                children: [
                  for (int index = 0; index < selectedTimes.length; index++)
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: TextField(
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.fromDateTime(DateTime.parse(
                                '1970-01-01 ${selectedTimes[index]}:00')),
                            context: context, //context of current state
                          );
                          if (pickedTime != null) {
                            String formattedTime = formatTime(pickedTime);
                            print(
                                "Selected time in 24-hour format: $formattedTime");
                            setState(() {
                              selectedTimes[index] = formattedTime;
                            });
                          } else {
                            print("No time selected");
                          }
                        },
                        readOnly: true,
                        style: GoogleFonts.roboto(
                          height: 2,
                          color: const Color.fromARGB(255, 16, 15, 15),
                        ),
                        cursorColor: const Color.fromARGB(255, 7, 82, 96),
                        decoration: InputDecoration(
                          hintText: TimeOfDay.fromDateTime(DateTime.parse(
                                  '1970-01-01 ${selectedTimes[index]}:00'))
                              .format(context),
                          labelText: TimeOfDay.fromDateTime(DateTime.parse(
                                  '1970-01-01 ${selectedTimes[index]}:00'))
                              .format(context),
                          hintStyle: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 16, 15, 15),
                          ),
                          labelStyle: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 16, 15, 15),
                          ),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
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
                      trailing: SizedBox(
                        height: double.maxFinite,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.remove_circle_outline_rounded),
                          color: Colors.red[900],
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 219, 228, 232),
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              )),
                          onPressed: () {
                            setState(() {
                              selectedTimes.removeAt(index); // Remove by index
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: TextField(
                  onTap: () {
                    // String time = TimeOfDay.fromDateTime(DateTime.now()).format(context);
                    String formattedTime =
                        formatTime(TimeOfDay.fromDateTime(DateTime.now()));

                    if (selectedTimes.isEmpty) {
                      setState(() {
                        selectedTimes.add(formattedTime);
                      });
                    } else if (selectedTimes.length == 24) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color.fromARGB(255, 7, 83, 96),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                          content: Text(
                            'Maximum medication times per day is 24',
                          ),
                        ),
                      );
                    } else {
                      String lastPlus10 = formatTime(TimeOfDay.fromDateTime(
                              DateTime.parse(
                                      '1970-01-01 ${selectedTimes.last}:00')
                                  .add(const Duration(minutes: 10))))
                          .toString();
                      print(lastPlus10);
                      if (selectedTimes.last.toString() == lastPlus10) {
                        setState(() {
                          selectedTimes.add(formattedTime);
                        });
                      } else {
                        setState(() {
                          selectedTimes.add(lastPlus10);
                        });
                      }
                    }
                  },
                  readOnly: true,
                  style: GoogleFonts.roboto(
                    height: 2,
                    color: const Color.fromARGB(255, 16, 15, 15),
                  ),
                  cursorColor: const Color.fromARGB(255, 7, 82, 96),
                  decoration: InputDecoration(
                    hintText: 'Add a time',
                    labelText: 'Add a time',
                    hintStyle: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 16, 15, 15),
                    ),
                    labelStyle: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 16, 15, 15),
                    ),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
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
                trailing: SizedBox(
                  height: double.maxFinite,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.add_circle_outline_rounded),
                    color: Colors.green[900],
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 219, 228, 232),
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    onPressed: () {
                      String formattedTime =
                          formatTime(TimeOfDay.fromDateTime(DateTime.now()));

                      if (selectedTimes.isEmpty) {
                        setState(() {
                          selectedTimes.add(formattedTime);
                        });
                      } else if (selectedTimes.length == 24) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(255, 7, 83, 96),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                            content: Text(
                              'Maximum medication times per day is 24',
                            ),
                          ),
                        );
                      } else {
                        String lastPlus10 = formatTime(TimeOfDay.fromDateTime(
                                DateTime.parse(
                                        '1970-01-01 ${selectedTimes.last}:00')
                                    .add(const Duration(minutes: 10))))
                            .toString();
                        print(lastPlus10);
                        if (selectedTimes.last.toString() == lastPlus10) {
                          setState(() {
                            selectedTimes.add(formattedTime);
                          });
                        } else {
                          setState(() {
                            selectedTimes.add(lastPlus10);
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
              // Column(
              //   children: selectedTimes
              //       .asMap()
              //       .entries
              //       .map(
              //         (entry) => ListTile(
              //           // title: Text(entry.value),
              //           title: TextField(
              //             onTap: () async {
              //               TimeOfDay? pickedTime = await showTimePicker(
              //                 initialTime: TimeOfDay.now(),
              //                 context: context, //context of current state
              //               );
              //               // TimeOfDay? formattedTime = pickedTime!
              //               //     .replacing(hour: pickedTime.hourOfPeriod);
              //               // print(formattedTime);
              //               if (pickedTime != null) {
              //                 String formattedTime = formatTime(pickedTime);
              //                 print(
              //                     "Selected time in 24-hour format: $formattedTime");
              //                 setState(() {
              //                   selectedTimes.add(formattedTime);
              //                 });
              //               } else {
              //                 print("No time selected");
              //               }
              //               // if (pickedTime != null) {
              //               //   // String time =
              //               //   //     '${pickedTime.hour}:${pickedTime.minute}';
              //               //   setState(() {
              //               //     selectedTimes.add(pickedTime.format(context));
              //               //   });
              //               //   //output 10:51 PM
              //               //   // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
              //               //   //converting to DateTime so that we can further format on different pattern.
              //               //   // print(parsedTime); //output 1970-01-01 22:53:00.000
              //               //   // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
              //               //   // print(formattedTime); //output 14:59:00
              //               //   //DateFormat() is from intl package, you can format the time on any pattern you need.
              //               // } else {
              //               //   print("Time is not selected");
              //               // }
              //             },
              //             readOnly: true,
              //             style: GoogleFonts.roboto(
              //               height: 2,
              //               color: const Color.fromARGB(255, 16, 15, 15),
              //             ),
              //             cursorColor: const Color.fromARGB(255, 7, 82, 96),
              //             decoration: InputDecoration(
              //               hintText: entry.value,
              //               labelText: entry.value,
              //               hintStyle: GoogleFonts.roboto(
              //                 color: const Color.fromARGB(255, 16, 15, 15),
              //               ),
              //               labelStyle: GoogleFonts.roboto(
              //                 color: const Color.fromARGB(255, 16, 15, 15),
              //               ),
              //               filled: true,
              //               floatingLabelBehavior: FloatingLabelBehavior.never,
              //               focusedBorder: const OutlineInputBorder(
              //                 borderRadius: BorderRadius.all(
              //                   Radius.circular(20),
              //                 ),
              //                 borderSide: BorderSide(
              //                   color: Colors.transparent,
              //                 ),
              //               ),
              //               enabledBorder: const OutlineInputBorder(
              //                 borderRadius: BorderRadius.all(
              //                   Radius.circular(20),
              //                 ),
              //                 borderSide: BorderSide(color: Colors.transparent),
              //               ),
              //             ),
              //           ),
              //           trailing: IconButton(
              //             icon: const Icon(Icons.delete),
              //             onPressed: () {
              //               setState(() {
              //                 selectedTimes.removeAt(entry.key);
              //               });
              //             },
              //           ),
              //         ),
              //       )
              //       .toList(),
              // ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                height: 2,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 20),
              Text(
                'When will you take this?',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  // navigate to add_medi_frequency.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMediFrequency(),
                    ),
                  );
                },
                child: const Text('Add Medication Frequency'),
              ),

              const SizedBox(height: 16),
              TextField(
                onTap: () async {
                  final DateTime? pickedStartDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: firstStartDate,
                    lastDate: lastStartDate,
                  );
                  if (pickedStartDate != null && pickedStartDate != startDate) {
                    setState(() {
                      startDate = pickedStartDate;
                      _startingDateController = TextEditingController(
                          text: startDate.toString().substring(0, 10));
                    });
                  }
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

              const SizedBox(height: 16),
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
                  const Text('Ending Date (Optional)'),
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
                    if (pickedEndDate != null && pickedEndDate != endDate) {
                      setState(() {
                        endDate = pickedEndDate;
                        _startingDateController = TextEditingController(
                            text: endDate.toString().substring(0, 10));
                      });
                    }
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
              const SizedBox(height: 24),
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
                child: const Text('Next'),
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
