// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mymeds_app/components/medcard.dart';

// import '../components/time_line.dart';
// import 'account_settings.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     late CalendarDateTime selectedDateTime = CalendarDateTime(
//         year: DateTime.now().year,
//         month: DateTime.now().month,
//         day: DateTime.now().day);

//     return Scaffold(
//       body: Column(
//         children: [
//           //app logo and user icon
//           Container(
//             padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
//             alignment: Alignment.topCenter,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 //logo and name
//                 Column(
//                   children: [
//                     //logo
//                     const Image(
//                       image: AssetImage('lib/assets/icon_small.png'),
//                       height: 50,
//                     ),
//                     //app name
//                     Text(
//                       'MyMeds',
//                       style: GoogleFonts.poppins(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: const Color.fromRGBO(7, 82, 96, 1),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // user icon widget
//                 UserIcon(),
//               ],
//             ),
//           ),

//           // calendar, selected date and reminder text widget
//           Calendar_Date_Reminder(
//             selectedDateTime: selectedDateTime,
//           ),

//           //timeline widget
//           Expanded(
//             child: GlowingOverscrollIndicator(
//               axisDirection: AxisDirection.down,
//               color: const Color.fromARGB(255, 7, 83, 96),
//               child: SingleChildScrollView(
//                 physics: ScrollPhysics(),
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: Timeline_Cards(
//                     selectedDateTime: selectedDateTime,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// //user icon widget
// class UserIcon extends StatefulWidget {
//   const UserIcon({super.key});

//   @override
//   State<UserIcon> createState() => _UserIconState();
// }

// class _UserIconState extends State<UserIcon> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return SettingsPageUI();
//                 },
//               ),
//             );
//           },
//           child: CircleAvatar(
//             radius: 20,
//             child: const Icon(Icons.person_outlined),
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             foregroundColor: Theme.of(context).colorScheme.surface,
//           ),
//         ),
//       ],
//     );
//   }
// }

// //calendar widget
// class Calendar_Date_Reminder extends StatefulWidget {
//   Calendar_Date_Reminder({super.key, required this.selectedDateTime});

//   late CalendarDateTime selectedDateTime;

//   @override
//   State<Calendar_Date_Reminder> createState() =>
//       _Calendar_Date_ReminderState(selectedDateTime);
// }

// class _Calendar_Date_ReminderState extends State<Calendar_Date_Reminder> {
//   _Calendar_Date_ReminderState(this.selectedDateTime);

//   late CalendarDateTime selectedDateTime;

//   @override
//   void initState() {
//     super.initState();
//     selectedDateTime = CalendarDateTime(
//       year: DateTime.now().year,
//       month: DateTime.now().month,
//       day: DateTime.now().day,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//             child: TimelineCalendar(
//               calendarType: CalendarType.GREGORIAN,
//               calendarLanguage: "en",
//               calendarOptions: CalendarOptions(
//                 viewType: ViewType.DAILY,
//                 toggleViewType: true,
//                 headerMonthElevation: 0,
//               ),
//               dayOptions: DayOptions(
//                 compactMode: true,
//                 dayFontSize: 15,
//                 weekDaySelectedColor: Theme.of(context).colorScheme.primary,
//                 selectedBackgroundColor: Theme.of(context).colorScheme.primary,
//                 disableDaysBeforeNow: false,
//               ),
//               headerOptions: HeaderOptions(
//                   weekDayStringType: WeekDayStringTypes.SHORT,
//                   monthStringType: MonthStringTypes.FULL,
//                   backgroundColor: Colors.transparent,
//                   headerTextColor: Colors.black),
//               onChangeDateTime: (date) {
//                 setState(() {
//                   selectedDateTime = date;
//                 });
//               },
//               onDateTimeReset: (p0) {
//                 setState(() {
//                   selectedDateTime = p0;
//                 });
//               },
//               dateTime: selectedDateTime,
//             ),
//           ),
//         ),

//         //date text and reminder
//         Container(
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               //title
//               Text(
//                 // _currentDate.toString().substring(0, 10),
//                 // '$_selectedDate',
//                 selectedDateTime.toString().substring(0, 10),
//                 style: GoogleFonts.roboto(
//                   fontSize: 30,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               //reminder text
//               Text(
//                 'You currently have no reminders',
//                 style: GoogleFonts.roboto(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// //time line cards widget
// class Timeline_Cards extends StatefulWidget {
//   Timeline_Cards({super.key, required this.selectedDateTime});

//   late CalendarDateTime selectedDateTime;

//   @override
//   State<Timeline_Cards> createState() => _Timeline_CardsState(selectedDateTime);
// }

// class _Timeline_CardsState extends State<Timeline_Cards> {
//   late CalendarDateTime selectedDateTime;

//   _Timeline_CardsState(this.selectedDateTime);

//   ValueNotifier<CalendarDateTime> _selectedDate =
//       ValueNotifier<CalendarDateTime>(CalendarDateTime(
//           year: DateTime.now().year,
//           month: DateTime.now().month,
//           day: DateTime.now().day));

//   // ValueNotifier<CalendarDateTime> _selectedDate =
//   //     ValueNotifier<CalendarDateTime>(selectedDateTime);

//   User? currentUser = FirebaseAuth.instance.currentUser;

//   //document IDs
//   List<String> docIds = [];

//   //get docIDs
//   Future getDocIDs() async {
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(currentUser!.email)
//         .collection('Medications')
//         .get()
//         .then(
//           (snapshot) => snapshot.docs.forEach(
//             (document) {
//               print(document.reference);
//               docIds.add(document.reference.id);
//             },
//           ),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FutureBuilder(
//           future: getDocIDs(),
//           builder: (context, snapshot) {
//             return ListView.builder(
//               itemCount: docIds.length,
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return ValueListenableBuilder<CalendarDateTime>(
//                   valueListenable: _selectedDate,
//                   builder: (context, value, child) {
//                     return MedCard(
//                       documentID: docIds[index],
//                       index: index,
//                       size: docIds.length,
//                       selectedDate: value,
//                     );
//                   },
//                 );
//               },
//             );
//           },
//         )
//       ],
//     );
//   }
// }




// // class TImeLine_with_Cards extends StatefulWidget {
// //   const TImeLine_with_Cards({super.key});

// //   @override
// //   State<TImeLine_with_Cards> createState() => _TImeLine_with_CardsState();
// // }

// // class _TImeLine_with_CardsState extends State<TImeLine_with_Cards> {
// //   final currentUser = FirebaseAuth.instance.currentUser;

// //   // documnet IDs
// //   List<String> docIDs = [];

// //   //get docIDs
// //   Future getDocIDs() async {
// //     await FirebaseFirestore.instance
// //         .collection('Users')
// //         .doc(currentUser!.email!)
// //         .collection('Medications')
// //         .get()
// //         .then((snapshot) {
// //       snapshot.docs.forEach(
// //         (documnet) {
// //           docIDs.add(documnet.reference.id);
// //           print('DOCUMENT ID: ${documnet.reference.id}');
// //         },
// //       );
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     //medication collection
// //     CollectionReference medicationCollection = FirebaseFirestore.instance
// //         .collection('Users')
// //         .doc(currentUser!.email)
// //         .collection('Medications');
// //     print(medicationCollection);
// //     print('length: ${docIDs.length}');

// //     return FutureBuilder<DocumentSnapshot>(
// //       future: medicationCollection.doc(docIDs.first).get(),
// //       builder: (context, snapshot) {
// //         if (snapshot.hasData &&
// //             snapshot.connectionState == ConnectionState.done) {
// //           Map<String, dynamic> data =
// //               snapshot.data!.data() as Map<String, dynamic>;

// //           print('${data['medname']}');
// //           print('${data['category']}');

// //           return Expanded(
// //             child: GlowingOverscrollIndicator(
// //               axisDirection: AxisDirection.down,
// //               color: const Color.fromARGB(255, 7, 83, 96),
// //               child: ListView.builder(
// //                 physics: const AlwaysScrollableScrollPhysics(),
// //                 shrinkWrap: true,
// //                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
// //                 itemBuilder: (context, index) {
// //                   return const Column(
// //                     children: [
// //                       TimeLine(
// //                         isFirst: true,
// //                         isLast: false,
// //                         isPast: true,
// //                         medName: 'Vitamin C',
// //                         dosage: '1 Capsule',
// //                         time: '06:00 am',
// //                         isTaken: true,
// //                       ),
// //                       TimeLine(
// //                         isFirst: false,
// //                         isLast: false,
// //                         isPast: true,
// //                         medName: 'Panadol',
// //                         dosage: '2 Tablets',
// //                         time: '08:00 am',
// //                         isTaken: false,
// //                       ),
// //                       TimeLine(
// //                         isFirst: false,
// //                         isLast: false,
// //                         isPast: false,
// //                         medName: 'Vitamin D',
// //                         dosage: '0.5 Capsule',
// //                         time: '02:00 pm',
// //                         isTaken: false,
// //                       ),
// //                       TimeLine(
// //                         isFirst: false,
// //                         isLast: false,
// //                         isPast: false,
// //                         medName: 'Salbutimola',
// //                         dosage: '1.5 Capsule',
// //                         time: '03:00 pm',
// //                         isTaken: false,
// //                       ),
// //                       TimeLine(
// //                         isFirst: false,
// //                         isLast: true,
// //                         isPast: false,
// //                         medName: 'Vitamin E',
// //                         dosage: '1 Tablet',
// //                         time: '06:00 pm',
// //                         isTaken: false,
// //                       ),
// //                     ],
// //                   );
// //                 },
// //               ),
// //             ),
// //           );
// //         }
// //         return Center(
// //           child: LinearProgressIndicator(),
// //         );
// //       },
// //     );
// //   }
// // }
