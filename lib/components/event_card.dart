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
  final String category;
  final int medcount;
  final String time;
  final String time24H;
  final bool isTaken;
  final String selectedDate;
  final VoidCallback refreshCallback;

  const EventCard({
    super.key,
    required this.documentID,
    required this.isPast,
    required this.medName,
    required this.dosage,
    required this.category,
    required this.medcount,
    required this.time,
    required this.time24H,
    required this.isTaken,
    required this.selectedDate,
    required this.refreshCallback,
  });

  String categoryImagePath(String catgoryStr) {
    switch (catgoryStr) {
      case 'Capsule':
        return 'lib/assets/icons/pills.png';
      case 'Tablet':
        return 'lib/assets/icons/tablet.png';
      case 'Liquid':
        return 'lib/assets/icons/liquid.png';
      case 'Topical':
        return 'lib/assets/icons/tube.png';
      case 'Cream':
        return 'lib/assets/icons/cream.png';
      case 'Drops':
        return 'lib/assets/icons/drops.png';
      case 'Foam':
        return 'lib/assets/icons/foam.png';
      case 'Gel':
        return 'lib/assets/icons/tube.png';
      case 'Herbal':
        return 'lib/assets/icons/herbal.png';
      case 'Inhaler':
        return 'lib/assets/icons/inhalator.png';
      case 'Injection':
        return 'lib/assets/icons/syringe.png';
      case 'Lotion':
        return 'lib/assets/icons/lotion.png';
      case 'Nasal Spray':
        return 'lib/assets/icons/nasalspray.png';
      case 'Ointment':
        return 'lib/assets/icons/tube.png';
      case 'Patch':
        return 'lib/assets/icons/patch.png';
      case 'Powder':
        return 'lib/assets/icons/powder.png';
      case 'Spray':
        return 'lib/assets/icons/spray.png';
      case 'Suppository':
        return 'lib/assets/icons/suppository.png';
      default:
        return 'lib/assets/icons/medicine.png';
    }
  }

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
    List<String> dateStr = selectedDate.split('-');

    if (DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day) ==
        DateTime(int.parse(dateStr[0]), int.parse(dateStr[1]),
            int.parse(dateStr[2]))) {
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
          .doc('$selectedDate $time24H')
          .set(
        {
          'isTaken': true,
          'timeTaken': "${DateTime.now()}",
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
          .doc('$selectedDate $time24H')
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
            //alert dialog of med card
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
                      // List<String> timeStr = time.toString().split(':');
                      // print(time);
                      // int hour = int.parse(timeStr[0]);
                      // int minute = int.parse(timeStr[1]);

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
                          Visibility(
                            visible: medData['strength'] != null,
                            child: Text(
                              '${medData['strength']} ${medData['strength_unit']}',
                              style: GoogleFonts.roboto(
                                color: const Color.fromARGB(255, 16, 15, 15),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Take ${medData['medcount']} ${medData['category']}(s) at $time',
                            style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 16, 15, 15),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
                            visible: medData['user_note'] != null,
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
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 132, 153, 156),
                blurRadius: 5.0,
                offset: Offset(0, 2))
          ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //category image
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    // color: !isTaken
                    //     ? Theme.of(context).colorScheme.surface
                    //     : const Color.fromARGB(255, 16, 15, 15),
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      categoryImagePath(category),
                    ),
                    // child: Image(
                    //   image: AssetImage(categoryImagePath(category)),
                    //   height: MediaQuery.of(context).size.height * 0.25,
                    //   // width: MediaQuery.of(context).size.width * 0.6,
                    //   color: Theme.of(context).colorScheme.surface,
                    //   colorBlendMode: BlendMode.darken,
                    // ),
                  ),
                ),
                // Icon(
                //   Icons.medication,
                //   color: !isTaken
                //       ? Theme.of(context).colorScheme.surface
                //       : const Color.fromARGB(255, 16, 15, 15),
                // ),
                const SizedBox(
                  width: 15,
                ),
                //medication anem
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //medication name
                    Text(
                      medName,
                      textAlign: TextAlign.start,
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
                      '$medcount $category(s)',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: !isTaken
                            ? Theme.of(context).colorScheme.surface
                            : const Color.fromARGB(255, 16, 15, 15),
                      ),
                    ),
                  ],
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
