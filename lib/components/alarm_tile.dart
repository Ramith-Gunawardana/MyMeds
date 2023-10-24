import 'package:flutter/material.dart';

class AlarmTile extends StatelessWidget {
  final String date;
  final String time;
  final String title;
  final void Function() onPressed;
  final void Function()? onDismissed;

  const AlarmTile({
    Key? key,
    required this.date,
    required this.time,
    required this.title,
    required this.onPressed,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      direction: onDismissed != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      background: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 253, 96, 85),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        child: const Icon(
          Icons.delete_outline,
          size: 30,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onDismissed?.call(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Container(
          // color: Colors.white,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 100,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              // const Row(
              //   children: [
              //     Icon(Icons.keyboard_arrow_left_rounded, size: 15),
              //     Icon(Icons.keyboard_arrow_left_rounded, size: 15),
              //     Icon(Icons.delete_outline, size: 20),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
