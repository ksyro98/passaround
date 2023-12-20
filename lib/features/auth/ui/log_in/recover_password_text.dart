import 'package:flutter/material.dart';

class RecoverPasswordText extends StatelessWidget {
  final void Function() onPress;

  const RecoverPasswordText({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: onPress,
          child: const Text(
            "Recover password",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
