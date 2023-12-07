import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/components/language_constants.dart';
import 'package:mymeds_app/components/medcard2.dart';
import 'package:mymeds_app/screens/account_settings.dart';
import 'package:mymeds_app/screens/add_medication1.dart';

class Mediaction extends StatefulWidget {
  const Mediaction({super.key});

  @override
  State<Mediaction> createState() => _MediactionState();
}

class _MediactionState extends State<Mediaction> {
  // final user = FirebaseAuth.instance.currentUser;

  //bottom nav bar
  final int _selectedIndex = 1;

  /*Floating Action Button should reutrn add_medication1.dart file method
  and the method should return the floating action button.*/
  //Floating Action Button
  bool isFABvisible = true;

  //current user
  User? currentUser = FirebaseAuth.instance.currentUser;

  //document IDs of medicatiions
  late List<String> docIds = [];
  late List<String> dateIds = [];
  late List<String> timeIds = [];

  returnFAB() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMedication1(),
          ),
        );
      },
      backgroundColor: const Color.fromARGB(255, 146, 191, 199),
      child: const Icon(Icons.add),
    );
  }

  Future getDocIDs() async {
    docIds = [];
    dateIds = [];
    timeIds = [];

    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('Medications')
        .get();

    for (final document in snapshot.docs) {
      print('Medications Doc ID: ${document.reference.id}');
      docIds.add(document.reference.id);

      // final snapshot1 = await FirebaseFirestore.instance
      //     .collection('Users')
      //     .doc(currentUser!.email)
      //     .collection('Medications')
      //     .doc(document.reference.id)
      //     .collection('Logs')
      //     .get();

      // for (final document1 in snapshot1.docs) {
      //   print('Date ID: ${document1.reference.id}');
      //   List<String> dateTime = document1.reference.id.split(' ');
      //   docIds.add(document.reference.id);
      //   dateIds.add(dateTime[0]);
      //   timeIds.add(dateTime[1]);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         Icons.search,
      //         color: Colors.black,
      //       ),
      //       padding: const EdgeInsets.only(right: 20),
      //       onPressed: () {
      //         // Navigator.pop(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => const HomePage2()),
      //         // );
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ],
      //   // backgroundColor: Color.fromARGB(163, 206, 240, 247)
      //   // backgroundColor: Colors.white,
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
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
                        // child: currentUser!.photoURL!.isEmpty
                        //     ? CircleAvatar(
                        //         radius: 20,
                        //         backgroundColor:
                        //             Theme.of(context).colorScheme.primary,
                        //         foregroundColor:
                        //             Theme.of(context).colorScheme.surface,
                        //         child: const Icon(Icons.person_outlined),
                        //       )
                        //     : CircleAvatar(
                        //         radius: 20,
                        //         backgroundImage:
                        //             NetworkImage(currentUser!.photoURL!),
                        //         backgroundColor: Colors.transparent,
                        //       ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.surface,
                          child: const Icon(Icons.person_outlined),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //title
                // Text(
                //   'Medications',
                //   textAlign: TextAlign.center,
                //   style: GoogleFonts.roboto(
                //     fontSize: 30,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                //medication gif
                Image.asset(
                  height: MediaQuery.of(context).size.height * 0.20,
                  'lib/assets/images/medication.gif',
                  color: const Color.fromARGB(255, 241, 250, 251),
                  colorBlendMode: BlendMode.darken,
                ),
              ],
            ),
            Expanded(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: const Color.fromARGB(255, 7, 83, 96),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: getDocIDs(),
                        builder: (context, snapshot) {
                          // print('${snapshot.hasData}');
                          // print(snapshot);
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // print('Building cards');
                            // print('DocID Array Length: ${docIds.length}');
                            if (docIds.isEmpty) {
                              // print('No reminders');
                              //no reminders widget
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'lib/assets/icons/no_reminders.gif',
                                      color: const Color.fromARGB(
                                          255, 241, 250, 251),
                                      colorBlendMode: BlendMode.darken,
                                      height: 100.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    translation(context).medicationText1,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddMedication1(),
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
                                    child: Text(
                                      translation(context).buttonText,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                itemCount: docIds.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MedCard2(medID: docIds[index]);
                                },
                              );
                            }
                          } else {
                            return const LinearProgressIndicator();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
