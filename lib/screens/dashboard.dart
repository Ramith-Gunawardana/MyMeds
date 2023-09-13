import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymeds_app/screens/add_medication1.dart';
// import 'package:mymeds_app/screens/settings.dart';
import 'package:mymeds_app/screens/homepage2.dart';
import 'package:mymeds_app/screens/medication.dart';
import 'package:mymeds_app/screens/more.dart';
// import 'package:my_navigation/stat';

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
      HomePage2(),
      //medication
      Mediaction(),
      //statistic
      // Statistic(),
      //settings
      More(),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMedication1(),
                  ),
                );
              },
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
          //settings
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
        // unselectedLabelStyle: GoogleFonts.roboto(
        //   fontWeight: FontWeight.w400,
        // ),
        // selectedLabelStyle: GoogleFonts.roboto(
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
