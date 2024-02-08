import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 8),
      child: Tooltip(
        message: "Profile",
        child: Icon(Icons.account_circle_outlined),
      ),
    );
  }
}
