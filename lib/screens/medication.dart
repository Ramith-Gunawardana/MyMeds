import 'package:flutter/material.dart';

class Mediaction extends StatefulWidget {
  const Mediaction({super.key});

  @override
  State<Mediaction> createState() => _MediactionState();
}

class _MediactionState extends State<Mediaction> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Medications'),
    );
  }
}
