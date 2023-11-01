import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectPhoto extends StatelessWidget {
  final String textLabel;
  final IconData icon;

  final void Function()? onTap;

  const SelectPhoto({
    Key? key,
    required this.textLabel,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(
    //   onPressed: onTap,
    //   style: ElevatedButton.styleFrom(
    //     elevation: 10,
    //     backgroundColor: Colors.grey.shade200,
    //     shape: const StadiumBorder(),
    //     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    //   ),
    //   // child: Padding(
    //   // padding: const EdgeInsets.symmetric(
    //   //   vertical: 16,
    //   //   horizontal: 6,
    //   // ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     // crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Icon(
    //         icon,
    //         color: Colors.black,
    //       ),
    //       const SizedBox(
    //         width: 14,
    //       ),
    //       Text(
    //         textLabel,
    //         style: const TextStyle(
    //           fontSize: 18,
    //           color: Colors.black,
    //         ),
    //       )
    //     ],
    //   ),
    // );

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
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
        label: Text(
          textLabel,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
