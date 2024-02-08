import 'package:flutter/material.dart';

class LinkTextBase extends StatelessWidget {

  final String text;
  final void Function() onClick;
  final double? fontSize;

  const LinkTextBase({super.key, required this.text, required this.onClick, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onClick,
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: fontSize,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
