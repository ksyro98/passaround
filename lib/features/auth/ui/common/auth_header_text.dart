import 'package:flutter/material.dart';

class AuthHeaderText extends StatelessWidget {
  final String text;

  const AuthHeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
