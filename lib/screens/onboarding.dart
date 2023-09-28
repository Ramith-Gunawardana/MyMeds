import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeds_app/components/onboarding_content.dart';

class Onboarding extends StatefulWidget {
  final void Function()? showSignInScreen;
  const Onboarding({super.key, required this.showSignInScreen});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), child: AppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //logo
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //logo
                  const Image(
                    image: AssetImage('lib/assets/icon_small.png'),
                    height: 60,
                  ),
                  //app name
                  Text(
                    'MyMeds',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(7, 82, 96, 1),
                    ),
                  ),
                ],
              ),
              //pages
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Image.asset(
                            contents[i].image,
                            color: const Color.fromARGB(255, 241, 250, 251),
                            colorBlendMode: BlendMode.darken,
                          )),
                          const SizedBox(height: 50),
                          //title
                          Text(
                            contents[i].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 27,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //description
                          Text(
                            contents[i].description,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              //dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceIn,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      height: 10.0,
                      width: (index == currentIndex) ? 20 : 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: (index == currentIndex)
                            ? (const Color.fromARGB(255, 27, 89, 101))
                            : (Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TextButton(
                  //   onPressed: widget.showSignInScreen,
                  //   child: const Text('Skip'),
                  //   // screenWidth: screenWidth,
                  // ),
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: TextButton(
                      onPressed: widget.showSignInScreen,
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(2),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: (currentIndex != 3),
                        child: SizedBox(
                          height: 50,
                          width: 140,
                          child: FilledButton(
                            onPressed: () {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                            },
                            style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(2),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            child: Text(
                              'Next',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        // child: FilledButton(
                        //   onPressed: () {
                        //     pageController.nextPage(
                        //         duration: const Duration(milliseconds: 500),
                        //         curve: Curves.decelerate);
                        //     // }
                        //   },
                        //   child: const Text('Next'),
                        // ),
                      ),
                      Visibility(
                        visible: (currentIndex == 3),
                        child: SizedBox(
                          height: 50,
                          width: 140,
                          child: FilledButton(
                            onPressed: widget.showSignInScreen,
                            style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(2),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            child: Text(
                              'Continue',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        // child: FilledButton(
                        //   onPressed: widget.showSignInScreen,
                        //   child: const Text('Continue'),
                        // ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
