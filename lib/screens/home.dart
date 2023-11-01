// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mymeds_app/components/time_line.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// import 'account_settings.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final user = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
//           alignment: Alignment.topCenter,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Column(
//                     children: [
//                       //logo
//                       const Image(
//                         image: AssetImage('lib/assets/icon_small.png'),
//                         height: 50,
//                       ),
//                       //app name
//                       Text(
//                         'MyMeds',
//                         style: GoogleFonts.roboto(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           color: const Color.fromRGBO(7, 82, 96, 1),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) {
//                       //       return SettingsPageUI();
//                       //     },
//                       //   ),
//                       // );
//                     },
//                     child: CircleAvatar(
//                       radius: 20,
//                       child: const Icon(Icons.person_outlined),
//                       backgroundColor: Theme.of(context).colorScheme.primary,
//                       foregroundColor: Theme.of(context).colorScheme.surface,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         // Text(
//         //   'Email:  ${user!.email!}',
//         // ),
//         // Text(
//         //   'Name:  ${user!.displayName!}',
//         // ),
//         // ElevatedButton(
//         //   onPressed: () {
//         //     FirebaseAuth.instance.signOut();
//         //   },
//         //   child: Text('Sign out'),
//         // ),
//         // ElevatedButton(
//         //   onPressed: () {
//         //     Navigator.push(
//         //       context,
//         //       MaterialPageRoute(
//         //         builder: (context) {
//         //           return const UserProfile();
//         //         },
//         //       ),
//         //     );
//         //   },
//         //   child: Text('User profile'),
//         // ),
//         // ElevatedButton(
//         //   onPressed: () {
//         //     Navigator.push(
//         //       context,
//         //       MaterialPageRoute(
//         //         builder: (context) {
//         //           return SettingsPageUI();
//         //         },
//         //       ),
//         //     );
//         //   },
//         //   child: Text('User settings'),
//         // ),

//         //calendar
//         Container(
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//             child: TimelineCalendar(
//               calendarType: CalendarType.GREGORIAN,
//               calendarLanguage: "en",
//               calendarOptions: CalendarOptions(
//                 viewType: ViewType.DAILY,
//                 toggleViewType: false,
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
//               onChangeDateTime: (datetime) {
//                 print(datetime.getDate());
//               },
//             ),
//           ),
//         ),

//         //date text
//         Container(
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               //title
//               Text(
//                 'Today',
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

//         //time line tile
//         Expanded(
//           child: GlowingOverscrollIndicator(
//             axisDirection: AxisDirection.down,
//             color: const Color.fromARGB(255, 7, 83, 96),
//             child: ListView(
//               physics: AlwaysScrollableScrollPhysics(),
//               shrinkWrap: true,
//               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//               children: const [
//                 TimeLine(
//                   isFirst: true,
//                   isLast: false,
//                   isPast: true,
//                   medName: 'Vitamin C',
//                   dosage: '1 Capsule',
//                   time: '06:00 am',
//                   isTaken: true,
//                 ),
//                 TimeLine(
//                   isFirst: false,
//                   isLast: false,
//                   isPast: true,
//                   medName: 'Panadol',
//                   dosage: '2 Tablets',
//                   time: '08:00 am',
//                   isTaken: false,
//                 ),
//                 TimeLine(
//                   isFirst: false,
//                   isLast: false,
//                   isPast: false,
//                   medName: 'Vitamin D',
//                   dosage: '0.5 Capsule',
//                   time: '02:00 pm',
//                   isTaken: false,
//                 ),
//                 TimeLine(
//                   isFirst: false,
//                   isLast: false,
//                   isPast: false,
//                   medName: 'Salbutimola',
//                   dosage: '1.5 Capsule',
//                   time: '03:00 pm',
//                   isTaken: false,
//                 ),
//                 TimeLine(
//                   isFirst: false,
//                   isLast: true,
//                   isPast: false,
//                   medName: 'Vitamin E',
//                   dosage: '1 Tablet',
//                   time: '06:00 pm',
//                   isTaken: false,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
