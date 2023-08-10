import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mymeds_app/screens/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:mymeds_app/screens/edit_profile.dart';
import 'package:mymeds_app/screens/help_center.dart';
import 'package:mymeds_app/screens/notification_settings.dart';
import 'package:mymeds_app/screens/terms_of_services.dart';

// import 'package:settings/usersettings.dart';

class SettingsPageUI extends StatefulWidget {
  @override
  _SettingPageUIState createState() => _SettingPageUIState();
}

class _SettingPageUIState extends State<SettingsPageUI> {
  bool ValueNotify1 = false;
  bool ValueNotify2 = false;
  // bool ValueNotify3 = false;

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select Language'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'සිංහල');
              },
              child: const Text('සිංහල'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'English');
              },
              child: const Text('English'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'தமிழ்');
              },
              child: const Text('தமிழ்'),
            ),
          ],
        );
      },
    ).then((selectedLanguage) {
      if (selectedLanguage != null) {
        print('Selected language: $selectedLanguage');
      }
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  //*****THEME DATA****

  // onChangeFunction1(bool newValue1) {
  //   setState(() {
  //     ValueNotify1 = newValue1;
  //   });
  //   final themeProvider = Provider.of<ThemeProvider>(
  //     context, listen: false);

  //   if (newValue1) {
  //     themeProvider.setThemeData(darkTheme);
  //   } else {
  //     themeProvider.setThemeData(lightTheme);
  //   }
  // }

  onChangeFunction2(bool newValue2) {
    setState(() {
      ValueNotify2 = newValue2;
    });
  }

  // onChangeFunction3(bool newValue3) {
  //   setState(() {
  //     ValueNotify3 = newValue3;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(
    //   context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settttings UI",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        elevation: 5,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person_2_outlined),
                    ),
                    // Image.asset(
                    //   'assets/images/user.webp',
                    //   height: 50,
                    //   width: 50,
                    // ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Pubudu Ashan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "pubuduashan01@gmail.com",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Your Account",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(height: 20, thickness: 2),
                const SizedBox(height: 10),
                buildAccountOption(
                    context, "   Edit Profile", Icons.edit_square),
                buildAccountOption(context, "   Notification Settings",
                    Icons.notifications_active),
                const SizedBox(height: 20),

                // const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.app_settings_alt_rounded,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "App Setting",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(height: 20, thickness: 2),
                const SizedBox(height: 10),
                buildAccountOption(
                    context, "   Help Center", Icons.help_center_outlined),
                buildAccountOption(context, "   Terms of Services",
                    Icons.safety_check_outlined),
                // buildOptionList(context, "   Language Selection"),
                buildAccountOption(
                    context, "   Select Language", Icons.language_sharp),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Other Settings",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(height: 10, thickness: 2),
                const SizedBox(height: 10),
                // buildNotificationOption(
                //     "Theme Dark", ValueNotify1,
                //      onChangeFunction1),
                buildNotificationOption(
                    "Account Active", ValueNotify2, onChangeFunction2),
                // buildNotificationOption(
                //     "Opportunity", ValueNotify3,
                //      onChangeFunction3),
                const SizedBox(height: 10),
                Center(
                  // child: OutlinedButton(
                  //   style: OutlinedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(horizontal: 40),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20))),
                  //   onPressed: () {},
                  //   // child:Text("Sign Out", style:TextStyle(
                  //   //   fontSize: 16,
                  //   //   letterSpacing: 2.2,
                  //   //   color: Color.fromARGB(246, 233, 3, 3)
                  //   // )),
                  //   child: const Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.logout,
                  //         color: Color.fromARGB(246, 255, 0, 0),
                  //       ),
                  //       SizedBox(width: 5),
                  //       Text(
                  //         "Sign Out",
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //           letterSpacing: 2.2,
                  //           color: Color.fromARGB(246, 255, 0, 0),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child:const Text('Sign out'),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 1, 1, 1),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "© 2023 MyMeds. All rights reserved.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 190, 181, 181),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 33, 86, 243),
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: const Color.fromARGB(255, 59, 255, 62),
              trackColor: const Color.fromARGB(255, 255, 0, 0),
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(
      BuildContext context, String title, IconData iconData) {
    return GestureDetector(
      onTap: () {
        if (title == "   Edit Profile") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>const UserProfile()),
          );
        } else if (title == "   Notification Settings") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationSettings()),
          );
        } else if (title == "   Help Center") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpCenter()),
          );
        } else if (title == "   Terms of Services") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TermsOfServices()),
          );
        } else if (title == "   Select Language") {
          _showLanguageSelectionDialog(context);
        } else {}
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 33, 86, 243),
              child: Icon(
                iconData,
                color: const Color.fromARGB(255, 231, 233, 237),
              ),
            ),
            //  const SizedBox(width: 10),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 33, 86, 243),
                  )),
            ),
            // const SizedBox(width: 80),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
