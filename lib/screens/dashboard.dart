import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/screens/account_settings.dart';
import 'package:mymeds_app/screens/emergency.dart';
import 'package:mymeds_app/screens/home.dart';
import 'package:mymeds_app/screens/medication.dart';
import 'package:mymeds_app/screens/set_photo_screen.dart';
import 'package:mymeds_app/screens/statistic.dart';
import 'package:mymeds_app/screens/user_profile.dart';
import 'package:mymeds_app/screens/settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser;

  //bottom nav bar
  int _selectedIndex = 0;

  //Floating Action Button
  bool isFABvisible = false;

  // // documnet IDs
  // List<String> docIDs = [];

  // //get docIDs
  // Future getDocIDs() async {
  //   await FirebaseFirestore.instance.collection('users').get().then(
  //         (snapshot) => snapshot.docs.forEach(
  //           (documnet) {
  //             print(documnet.reference);
  //             docIDs.add(documnet.reference.id);
  //           },
  //         ),
  //       );
  // }

  // @override
  // void initState() {
  //   getDocIDs();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //pages
    final List<Widget> _pages = <Widget>[
      //main page
      const Home(),
      //medication
      const Mediaction(),
      //statistic
      const Statistic(),

      Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'App Settings',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: Colors.black,
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context,
        //       MaterialPageRoute(
        //         builder: (context) =>const Home(),
        //         ),);
        //     },
        //   ),
        // ),
        // body: ListView(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(16.0),
        //        child: Card(
        //         elevation: 4, // Add some elevation for a card effect
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(16.0), // Rounded corners
        //         ),
        //         child: GestureDetector(
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => const SetPhotoScreen(),
        //               ),
        //             );
        //           },
        //           child: Container(
        //             height: 100,
        //             width: 150,
        //             alignment: Alignment.center,
        //             color: Colors.grey.shade200,
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                const Icon(
        //                   Icons.camera_alt_sharp,
        //                   size: 40,
        //                   color:  Color.fromARGB(255, 246, 68, 37),
        //                 ),
        //                 const SizedBox(height: 8),
        //                 Text(
        //                   'Camera',
        //                   style: GoogleFonts.dancingScript(
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     // Add other settings content here
        //   ],
        // ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children:[ 

            //1st ROW

            Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160, height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPhotoScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.camera_alt_sharp,
                      color: Colors.black,
                    ),
                    label: const Text('Camera',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 68, 250, 74),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ) 
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160, 
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPhotoScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_location_alt_sharp,
                      color: Colors.black,
                    ),
                    label: const Text('Map',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          ),

          const SizedBox(
              width: 40,
              height: 30,
            ),

            //2nd ROW

          Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160, height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPhotoScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.calculate,
                      color: Colors.black,
                    ),
                    label: const Text('BMI',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:const Color.fromARGB(255, 241, 255, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ) 
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160, 
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPhotoScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.alarm,
                      color: Colors.black,
                    ),
                    label: const Text('Alarm',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 223, 17, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          ),

          const SizedBox(
              width: 40,
              height: 30,
            ),

            //3rd ROW

          Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160, height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Emergency(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.account_box,
                      color: Colors.black,
                    ),
                    label: const Text('Emergency Calls',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:const Color.fromARGB(255, 254, 37, 37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ) 
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160, 
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPhotoScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.medical_information,
                      color: Colors.black,
                    ),
                    label: const Text('Medicine',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 68, 243, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          ),
          const SizedBox(
              width: 40,
              height: 30,
            ),

            //4th ROW

          Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160, height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPhotoScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.history,
                      color: Colors.black,
                    ),
                    label: const Text('History',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:const Color.fromARGB(255, 255, 136, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ) 
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160, 
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPhotoScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.food_bank,
                      color: Colors.black,
                    ),
                    label: const Text('Foods',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 152, 0, 246),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          ),
          ],
        ),
      ),),
    ];

    //scaffold
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: SafeArea(
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      //floating action button
      floatingActionButton: isFABvisible
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(50.0),
              //   ),
              // ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.background,
            )
          : null,
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      //bottom navigation
      bottomNavigationBar: NavigationBar(
        // type: BottomNavigationBarType.fixed,
        destinations: const [
          //home
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Color.fromRGBO(7, 82, 96, 1),
            ),
            label: 'Home',
            selectedIcon: Icon(
              Icons.home_rounded,
              color: Color.fromRGBO(7, 82, 96, 1),
            ),
          ),
          //medications
          NavigationDestination(
            icon: Icon(
              Icons.medication_outlined,
            ),
            label: 'Medications',
            selectedIcon: Icon(
              Icons.medication,
              color: Color.fromRGBO(7, 82, 96, 1),
            ),
          ),
          //history
          NavigationDestination(
            icon: Icon(
              Icons.analytics_outlined,
            ),
            label: 'Statistics',
            selectedIcon: Icon(
              Icons.analytics_rounded,
              color: Color.fromRGBO(7, 82, 96, 1),
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.dashboard_customize_outlined,
            ),
            label: 'More',
            selectedIcon: Icon(
              Icons.dashboard_customize_rounded,
              color: Color.fromRGBO(7, 82, 96, 1),
            ),
          ),
        ],
        // unselectedLabelStyle: GoogleFonts.poppins(
        //   fontWeight: FontWeight.w400,
        // ),
        // selectedLabelStyle: GoogleFonts.poppins(
        //   fontWeight: FontWeight.w600,
        // ),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int) {
          switch (int) {
            case 1: //home
              //show FAB in medication page
              isFABvisible = true;
              break;
            case 0:
            case 2:
            case 3:
              isFABvisible = false;
              break;
          }

          setState(() {
            _selectedIndex = int;
          });
        },
      ),
    );
  }
}
