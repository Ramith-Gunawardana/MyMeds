import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class EventCard extends StatelessWidget {
  final String documentID;
  final bool isPast;
  final String medName;
  final String dosage;
  final String time;
  final bool isTaken;
  final String selectedDate;
  final VoidCallback refreshCallback;

  const EventCard({
    super.key,
    required this.documentID,
    required this.isPast,
    required this.medName,
    required this.dosage,
    required this.time,
    required this.isTaken,
    required this.selectedDate,
    required this.refreshCallback,
  });

  @override
  Widget build(BuildContext context) {
    String takenTxt;
    IconData takenIcon;

    User? currentUser = FirebaseAuth.instance.currentUser;
    //get the collection
    CollectionReference medications = FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('Medications');

    if (isPast) {
      if (isTaken) {
        takenTxt = 'Taken';
        takenIcon = Icons.done;
      } else {
        takenTxt = 'Missed';
        takenIcon = Icons.close;
      }
    } else {
      takenTxt = 'Not yet';
      takenIcon = Icons.schedule;
    }

    Future takeMed() async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .collection('Medications')
          .doc(documentID)
          .collection('Logs')
          .doc(selectedDate)
          .set(
        {
          'isTaken': true,
          'timeTaken': "",
        },
      );
    }

    Future missMed() async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .collection('Medications')
          .doc(documentID)
          .collection('Logs')
          .doc(selectedDate)
          .set(
        {
          'isTaken': false,
          'timeTaken': "",
        },
      );
    }

    return GestureDetector(
      onTap: () {
        // print(DateTime.now().toString().substring(0, 10));
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // title: Text(
              //   'Medication details',
              //   style: GoogleFonts.roboto(
              //     color: const Color.fromARGB(255, 16, 15, 15),
              //   ),
              // ),
              actions: [
                //button to mark skip - visible only for today date
                Visibility(
                  visible: selectedDate ==
                      DateTime.now().toString().substring(0, 10),
                  child: TextButton.icon(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      missMed();
                      refreshCallback();
                      Navigator.pop(context);
                    },
                    label: const Text('Skip'),
                  ),
                ),
                //button to mark take - visible only for today date
                Visibility(
                  visible: selectedDate ==
                      DateTime.now().toString().substring(0, 10),
                  child: TextButton.icon(
                    icon: const Icon(Icons.check_rounded),
                    onPressed: () {
                      takeMed();
                      refreshCallback();
                      Navigator.pop(context);
                    },
                    label: const Text('Take'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
              content: FutureBuilder(
                future: medications
                    .doc(documentID)
                    .get(const GetOptions(source: Source.cache)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      Map<String, dynamic>? medData =
                          snapshot.data!.data() != null
                              ? snapshot.data!.data() as Map<String, dynamic>
                              : <String, dynamic>{};

                      // print(snapshot.data!.data());
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${medData['medname']}',
                            style: GoogleFonts.roboto(
                                color: const Color.fromARGB(255, 16, 15, 15),
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${medData['strength']} ${medData['strength_unit']}',
                            style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 16, 15, 15),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Take ${medData['medcount']} ${medData['category']}(s) at ${medData['times']}',
                            style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 16, 15, 15),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Since ${medData['start_date']}',
                            style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 16, 15, 15),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: medData['user_note'].toString().isNotEmpty,
                            child: Text(
                              'Note: ${medData['user_note']}',
                              style: GoogleFonts.roboto(
                                color: const Color.fromARGB(255, 16, 15, 15),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: const SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              BannerPlaceholder(),
                            ],
                          ),
                        ));
                  }
                  return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: const SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BannerPlaceholder(),
                          ],
                        ),
                      ));
                },
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(25.0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: isPast
          //     ? const Color.fromARGB(255, 6, 129, 151)
          //     : const Color.fromARGB(255, 183, 197, 200),
          color: isTaken
              ? const Color.fromARGB(255, 183, 197, 200)
              : Theme.of(context).colorScheme.primary,
        ),
        // child: Text(
        //   'Card',
        //   style: TextStyle(
        //     color: isPast
        //         ? Theme.of(context).colorScheme.surface
        //         : const Color.fromARGB(255, 16, 15, 15),
        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.medication,
              color: !isTaken
                  ? Theme.of(context).colorScheme.surface
                  : const Color.fromARGB(255, 16, 15, 15),
            ),
            //medication anem
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //medication name
                Text(
                  medName,
                  style: GoogleFonts.roboto(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: !isTaken
                        ? Theme.of(context).colorScheme.surface
                        : const Color.fromARGB(255, 16, 15, 15),
                  ),
                ),
                //dosage
                Text(
                  dosage,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: !isTaken
                        ? Theme.of(context).colorScheme.surface
                        : const Color.fromARGB(255, 16, 15, 15),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //time
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                  child: Text(
                    time,
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: !isTaken
                          ? Theme.of(context).colorScheme.surface
                          : const Color.fromARGB(255, 16, 15, 15),
                    ),
                  ),
                ),
                //taken icon and text
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Icon(
                      takenIcon,
                      color: !isTaken
                          ? Theme.of(context).colorScheme.surface
                          : const Color.fromARGB(255, 16, 15, 15),
                      size: 15,
                    ),
                  ),
                  Text(
                    takenTxt,
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: !isTaken
                          ? Theme.of(context).colorScheme.surface
                          : const Color.fromARGB(255, 16, 15, 15),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 25.0,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 20.0,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 20.0,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 20.0,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 20.0,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
