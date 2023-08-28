import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _Emergency();
}

class _Emergency extends State<Emergency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Emergency calls"),
      ),
      // body: Center(
      //   // child: ElevatedButton(
      //   //   onPressed: () async{
      //   //     final Uri url =Uri(
      //   //       scheme: 'tel',
      //   //       path: "+94714686902"
      //   //     );
      //   //     if (await canLaunchUrl(url)){
      //   //       await launchUrl(url);
      //   //     }
      //   //     else{
      //   //       print('cannot launch');
      //   //     }
      //   //             },
      //   //   child:const Text("Call"),
      //   // ),
      // ),

      body: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children:[ 

            Column(mainAxisAlignment: MainAxisAlignment.center,
             children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 360, height: 80,
                  child: ElevatedButton.icon(
                    onPressed: () async{
            final Uri url =Uri(
              scheme: 'tel',
              path: "+94714686902"
            );
            if (await canLaunchUrl(url)){
              await launchUrl(url);
            }
            else{
              print('cannot launch');
            }
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    label: const Text('Police Emergency - 119',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:const Color.fromARGB(255, 153, 155, 153),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ) 
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 360, 
                  height: 80,
                  child: ElevatedButton.icon(
                    onPressed: () async{
            final Uri url =Uri(
              scheme: 'tel',
              path: "+94714686902"
            );
            if (await canLaunchUrl(url)){
              await launchUrl(url);
            }
            else{
              print('cannot launch');
            }
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    label: const Text('Government Information Center - 1919',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 153, 155, 153),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 360, 
                  height: 80,
                  child: ElevatedButton.icon(
                    onPressed: () async{
            final Uri url =Uri(
              scheme: 'tel',
              path: "+94714686902"
            );
            if (await canLaunchUrl(url)){
              await launchUrl(url);
            }
            else{
              print('cannot launch');
            }
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    label: const Text('Suwa Seriya Ambulance - 1990',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 153, 155, 153),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 360, 
                  height: 80,
                  child: ElevatedButton.icon(
                    onPressed: () async{
            final Uri url =Uri(
              scheme: 'tel',
              path: "+94714686902"
            );
            if (await canLaunchUrl(url)){
              await launchUrl(url);
            }
            else{
              print('cannot launch');
            }
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    label: const Text('Ambulance / Fire & rescue - 110',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 153, 155, 153),
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
          ] 
      ),
      ),
 
    );
  }
}
