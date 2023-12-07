import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mymeds_app/components/language_constants.dart';
import 'package:mymeds_app/screens/account_settings.dart';
import 'package:mymeds_app/screens/alarm_settings.dart';
import 'package:mymeds_app/screens/bmi.dart';
import 'package:mymeds_app/screens/emergency.dart';
import 'package:mymeds_app/screens/set_photo_screen.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _SettingsState();
}

class _SettingsState extends State<More> {
  Position? _currentPosition;
  //current user
  User? currentUser = FirebaseAuth.instance.currentUser;

  // @override
  // void initState() {
  //   super.initState();
  //   _getCurrentLocation();
  // }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled, show a dialog to enable them.
        _showLocationServiceAlertDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // The user has denied access to location permissions.
          print(translation(context).locD);
          return;
        }
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          _currentPosition = position;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // Method to show the dialog to enable location services.
  void _showLocationServiceAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(translation(context).loc),
          content: Text(translation(context).locSe),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                bool serviceEnabled = await Geolocator.openLocationSettings();
                if (serviceEnabled) {
                  // Location services are now enabled, try getting the location again.
                  await _getCurrentLocation();
                }
              },
              child: Text(translation(context).enable),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(translation(context).cancel),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: [
              //app logo and user icon
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //logo and name
                    const Column(
                      children: [
                        //logo
                        Image(
                          image: AssetImage('lib/assets/icon_small.png'),
                          height: 50,
                        ),
                        //app name
                        // Text(
                        //   'MyMeds',
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w600,
                        //     color: const Color.fromRGBO(7, 82, 96, 1),
                        //   ),
                        // ),
                      ],
                    ),

                    // user icon widget
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SettingsPageUI();
                                },
                              ),
                            );
                          },
                          child: (currentUser?.photoURL?.isEmpty ?? true)
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  child: const Icon(Icons.person_outlined),
                                )
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(currentUser!.photoURL!),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: const AssetImage('lib/assets/icons/more.gif'),
                  height: MediaQuery.of(context).size.height * 0.25,
                  // width: MediaQuery.of(context).size.width * 0.6,
                  color: const Color.fromARGB(255, 241, 250, 251),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              //1st ROW
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SetPhotoScreen(),
                              ),
                            );
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.image_outlined,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(translation(context).presImg,
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FilledButton(
                          onPressed: () async {
                            await _getCurrentLocation();
                            if (_currentPosition != null) {
                              MapsLauncher.launchQuery(
                                  translation(context).nearby);
                            }
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.location_on_outlined,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(translation(context).nearby,
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //2nd ROW

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BMI(),
                              ),
                            );
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.health_and_safety_outlined,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(translation(context).bmi,
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const AlarmSettingsPage();
                                },
                              ),
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     backgroundColor:
                            //         Color.fromARGB(255, 7, 83, 96),
                            //     behavior: SnackBarBehavior.floating,
                            //     duration: Duration(seconds: 2),
                            //     content: Text(
                            //       'Coming soon...',
                            //     ),
                            //   ),
                            // );
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.alarm_rounded,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(translation(context).upalarm,
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //3rd row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Emergency(),
                              ),
                            );
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.call_outlined,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(translation(context).emgcall,
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),

              //3rd ROW

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Container(
              //           width: 160,
              //           height: 100,
              //           child: ElevatedButton.icon(
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => const SetPhotoScreen(),
              //                 ),
              //               );
              //             },
              //             icon: const Icon(
              //               Icons.account_box,
              //               color: Colors.black,
              //             ),
              //             label: const Text('Profile',
              //                 style: TextStyle(color: Colors.black)),
              //             style: ElevatedButton.styleFrom(
              //                 backgroundColor:
              //                     const Color.fromARGB(255, 254, 37, 37),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                 )),
              //           ),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Container(
              //           width: 160,
              //           height: 100,
              //           child: ElevatedButton.icon(
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => const SetPhotoScreen(),
              //                 ),
              //               );
              //             },
              //             icon: const Icon(
              //               Icons.medical_information,
              //               color: Colors.black,
              //             ),
              //             label: const Text('Medicine',
              //                 style: TextStyle(color: Colors.black)),
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor:
              //                   const Color.fromARGB(255, 68, 243, 255),
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   width: 40,
              //   height: 30,
              // ),

              // //4th ROW

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Container(
              //           width: 160,
              //           height: 100,
              //           child: ElevatedButton.icon(
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => const SetPhotoScreen(),
              //                 ),
              //               );
              //             },
              //             icon: const Icon(
              //               Icons.history,
              //               color: Colors.black,
              //             ),
              //             label: const Text('History',
              //                 style: TextStyle(color: Colors.black)),
              //             style: ElevatedButton.styleFrom(
              //                 backgroundColor:
              //                     const Color.fromARGB(255, 255, 136, 0),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                 )),
              //           ),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Container(
              //           width: 160,
              //           height: 100,
              //           child: ElevatedButton.icon(
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => const SetPhotoScreen(),
              //                 ),
              //               );
              //             },
              //             icon: const Icon(
              //               Icons.food_bank,
              //               color: Colors.black,
              //             ),
              //             label: const Text('Foods',
              //                 style: TextStyle(color: Colors.black)),
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor:
              //                   const Color.fromARGB(255, 152, 0, 246),
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
