import 'package:flutter/material.dart';

class CircledLetter extends StatelessWidget {
  final String letter;

  const CircledLetter({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(360)),
      ),
      alignment: Alignment.center,
      child: Text(
        letter.characters.first.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.w300,
          fontSize: 66,
        ),
      ),
    );
  }
}
