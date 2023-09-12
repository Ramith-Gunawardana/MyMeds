import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final String medName;
  final String dosage;
  final String time;
  final bool isTaken;

  const EventCard({
    super.key,
    required this.isPast,
    required this.medName,
    required this.dosage,
    required this.time,
    required this.isTaken,
  });

  @override
  Widget build(BuildContext context) {
    String takenTxt;
    IconData takenIcon;

    if (isPast) {
      if (isTaken) {
        takenTxt = 'Taken';
        takenIcon = Icons.done;
      } else {
        takenTxt = 'Missed';
        takenIcon = Icons.close;
      }
    } else {
      takenTxt = 'Not yet';
      takenIcon = Icons.schedule;
    }
    return Container(
      margin: const EdgeInsets.all(25.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isPast
            ? const Color.fromARGB(255, 6, 129, 151)
            : const Color.fromARGB(255, 183, 197, 200),
      ),
      // child: Text(
      //   'Card',
      //   style: TextStyle(
      //     color: isPast
      //         ? Theme.of(context).colorScheme.surface
      //         : const Color.fromARGB(255, 16, 15, 15),
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.medication,
            color: isPast
                ? Theme.of(context).colorScheme.surface
                : const Color.fromARGB(255, 16, 15, 15),
          ),
          //medication anem
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //medication name
              Text(
                medName,
                style: GoogleFonts.roboto(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: isPast
                      ? Theme.of(context).colorScheme.surface
                      : const Color.fromARGB(255, 16, 15, 15),
                ),
              ),
              //dosage
              Text(
                dosage,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: isPast
                      ? Theme.of(context).colorScheme.surface
                      : const Color.fromARGB(255, 16, 15, 15),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //time
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                child: Text(
                  time,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: isPast
                        ? Theme.of(context).colorScheme.surface
                        : const Color.fromARGB(255, 16, 15, 15),
                  ),
                ),
              ),
              //taken icon and text
              Row(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Icon(
                    takenIcon,
                    color: isPast
                        ? Theme.of(context).colorScheme.surface
                        : const Color.fromARGB(255, 16, 15, 15),
                    size: 15,
                  ),
                ),
                Text(
                  takenTxt,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: isPast
                        ? Theme.of(context).colorScheme.surface
                        : const Color.fromARGB(255, 16, 15, 15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
