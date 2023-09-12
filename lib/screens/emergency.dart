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
        // child: ElevatedButton(
        //   onPressed: () async{
        //     final Uri url =Uri(
        //       scheme: 'tel',
        //       path: "+94714686902"
        //     );
        //     if (await canLaunchUrl(url)){
        //       await launchUrl(url);
        //     }
        //     else{
        //       print('cannot launch');
        //     }
        //             },
        //   child:const Text("Call"),
        // ),
      // ), 

      body:  Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            Image.asset(
              'lib/assets/emer1.gif',
              height: 200, 
            ),
            const SizedBox(height: 8),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("110"),
              icon: Icons.local_police,
              label: 'Fire & rescue - 110',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("118"),
              icon: Icons.medical_services_rounded,
              label: 'Police Emergency - 118/119',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("1990"),
              icon: Icons.fire_truck,
              label: 'Suwa Seriya Ambulance - 1990',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("0112691111"),
              icon: Icons.info_rounded,
              label: 'Accident Service - 011 2691111',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("1919"),
              icon: Icons.emergency_sharp,
              label: 'Government Information Center - 1919',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("0115717171"),
              icon: Icons.miscellaneous_services_outlined,
              label: 'Emergency Police Squad	- 011 5717171',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makeEmergencyCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Cannot launch');
    }
  }
}

class _EmergencyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const _EmergencyButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          const SizedBox(width: 10), // Add some spacing between icon and text
          Text(
            label,
            style: TextStyle(color: Colors.black),
          ),
          const Spacer(), // Pushes the content to the left
          ElevatedButton(
            onPressed: onPressed,
            child: Text('Call'),
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 153, 155, 153),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}


          // children:[ 
          //   Column(mainAxisAlignment: MainAxisAlignment.center,
          //    children: [
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Container(
          //         width: 360,
          //         height: 80,
          //         child: ElevatedButton.icon(
          //           onPressed: () async{
          //   final Uri url =Uri(
          //     scheme: 'tel',
          //     path: "+94714686902"
          //   );
          //   if (await canLaunchUrl(url)){
          //     await launchUrl(url);
          //   }
          //   else{
          //     print('cannot launch');
          //   }
          //           },
          //           icon: const Icon(
          //             Icons.call,
          //             color: Colors.black,
          //           ),
          //           label: const Text('Police Emergency - 119',
          //               style: TextStyle(color: Colors.black)),
          //           style: ElevatedButton.styleFrom(
          //               backgroundColor:const Color.fromARGB(255, 153, 155, 153),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10),
          //               ) 
          //               ),
          //         ),
          //       ),
          //     ],
          //   ),
            // const SizedBox(
            //   height: 40,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: 360, 
            //       height: 80,
            //       child: ElevatedButton.icon(
            //         onPressed: () async{
            // final Uri url =Uri(
            //   scheme: 'tel',
            //   path: "+94714686902"
            // );
            // if (await canLaunchUrl(url)){
            //   await launchUrl(url);
            // }
            // else{
            //   print('cannot launch');
            // }
            //         },
            //         icon: const Icon(
            //           Icons.call,
            //           color: Colors.black,
            //         ),
            //         label: const Text('Government Information Center - 1919',
            //             style: TextStyle(color: Colors.black)),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor:const Color.fromARGB(255, 153, 155, 153),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: 360, 
            //       height: 80,
            //       child: ElevatedButton.icon(
            //         onPressed: () async{
            // final Uri url =Uri(
            //   scheme: 'tel',
            //   path: "+94714686902"
            // );
            // if (await canLaunchUrl(url)){
            //   await launchUrl(url);
            // }
            // else{
            //   print('cannot launch');
            // }
            //         },
            //         icon: const Icon(
            //           Icons.call,
            //           color: Colors.black,
            //         ),
            //         label: const Text('Suwa Seriya Ambulance - 1990',
            //             style: TextStyle(color: Colors.black)),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor:const Color.fromARGB(255, 153, 155, 153),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: 360, 
            //       height: 80,
            //       child: ElevatedButton.icon(
            //         onPressed: () async{
            // final Uri url =Uri(
            //   scheme: 'tel',
            //   path: "+94714686902"
            // );
            // if (await canLaunchUrl(url)){
            //   await launchUrl(url);
            // }
            // else{
            //   print('cannot launch');
            // }
            //         },
            //         icon: const Icon(
            //           Icons.call,
            //           color: Colors.black,
            //         ),
            //         label: const Text('Ambulance / Fire & rescue - 110',
            //             style: TextStyle(color: Colors.black,),),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor:const Color.fromARGB(255, 153, 155, 153),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
//           ],
//           ),
//           ] 
//       ),
//       ),
 
//     );
//   }
// }
