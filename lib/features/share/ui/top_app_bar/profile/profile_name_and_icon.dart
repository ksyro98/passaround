import 'package:flutter/material.dart';
import 'package:passaround/features/share/ui/top_app_bar/profile/profile_icon.dart';

class ProfileNameAndIcon extends StatelessWidget {
  final String username;

  const ProfileNameAndIcon({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(username),
        const SizedBox(width: 4),
        const ProfileIcon(),
      ],
    );
  }
}
