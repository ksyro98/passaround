import 'package:flutter/material.dart';

class PasswordStrengthText extends StatelessWidget {
  static const String _text = "6 or more characters are required";

  const PasswordStrengthText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8, top: 6, bottom: 6),
          child: Text(_text),
        ),
      ],
    );
  }
}
