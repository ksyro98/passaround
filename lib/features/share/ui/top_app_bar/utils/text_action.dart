import 'package:flutter/material.dart';

class TextAction extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const TextAction({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(text),
        ),
      ),
    );
  }
}
