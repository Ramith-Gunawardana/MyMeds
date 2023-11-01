import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Alert_Dialog extends StatelessWidget {
  const Alert_Dialog(
      {super.key,
      required this.isError,
      required this.alertTitle,
      required this.errorMessage,
      required this.buttonText});

  final String alertTitle;
  final String errorMessage;
  final String buttonText;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        alertTitle,
        style: GoogleFonts.roboto(
          color: const Color.fromARGB(255, 16, 15, 15),
        ),
      ),
      content: Text(
        errorMessage,
        style: GoogleFonts.roboto(
          color: isError
              ? const Color.fromRGBO(255, 16, 15, 15)
              : const Color.fromRGBO(7, 82, 96, 1),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            buttonText,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 16, 15, 15),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
