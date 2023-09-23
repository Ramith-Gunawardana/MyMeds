// import 'package:flutter/material.dart';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:google_fonts/google_fonts.dart';

// class NotificationService {
//   NotificationService({required this.context});

//   BuildContext context;

//   //function to initialization
//   Future<void> initNotification() async {
//     AwesomeNotifications().initialize(
//         // set the icon to null if you want to use the default app icon
//         'resource://drawable/ic_stat_icon_small',
//         [
//           NotificationChannel(
//               channelGroupKey: 'basic_channel_group',
//               channelKey: 'basic_channel',
//               channelName: 'Basic notifications',
//               channelDescription: 'Notification channel for basic tests',
//               defaultColor: const Color.fromRGBO(7, 82, 96, 1),
//               channelShowBadge: true,
//               importance: NotificationImportance.Max,
//               ledColor: Colors.white)
//         ],
//         // Channel groups are only visual and are not required
//         channelGroups: [
//           NotificationChannelGroup(
//               channelGroupKey: 'basic_channel_group',
//               channelGroupName: 'Basic group')
//         ],
//         debug: true);

//     //check notification are allowd in Permissions
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         // This is just a basic example. For real apps, you must show some
//         // friendly dialog box before call the request method.
//         // This is very important to not harm the user experience
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text(
//                 'Notifications',
//                 style: GoogleFonts.roboto(
//                   color: const Color.fromARGB(255, 16, 15, 15),
//                 ),
//               ),
//               content: Text(
//                 'Would you like MyMeds to send notifications?',
//                 style: GoogleFonts.roboto(
//                   color: const Color.fromARGB(255, 16, 15, 15),
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text(
//                     'Don\'t allow',
//                     style: GoogleFonts.roboto(
//                       fontWeight: FontWeight.w600,
//                       color: const Color.fromARGB(255, 82, 82, 82),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 TextButton(
//                   child: Text(
//                     'Allow',
//                     style: GoogleFonts.roboto(
//                       fontWeight: FontWeight.w600,
//                       color: const Color.fromRGBO(7, 82, 96, 1),
//                     ),
//                   ),
//                   onPressed: () {
//                     AwesomeNotifications()
//                         .requestPermissionToSendNotifications()
//                         .then((_) => Navigator.of(context).pop());
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     });
//   }
// }
