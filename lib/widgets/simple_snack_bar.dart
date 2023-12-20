import 'package:flutter/material.dart';

class SimpleSnackBar extends SnackBar {
  final String message;

  static show(BuildContext context, String message, {Duration duration = const Duration(milliseconds: 4000)}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SimpleSnackBar(message: message, duration: duration));
    });
  }

  SimpleSnackBar({
    Key? key,
    required this.message,
    required Duration duration,
  }) : super(
          key: key,
          content: Text(message),
          duration: duration
        );
}
