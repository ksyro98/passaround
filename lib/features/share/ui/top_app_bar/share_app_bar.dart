import 'package:flutter/material.dart';
import 'package:passaround/entities/pa_user.dart';
import 'package:passaround/features/share/ui/top_app_bar/privacy_policy/privacy_policy_action.dart';
import 'package:passaround/features/share/ui/top_app_bar/profile/profile_action.dart';

import 'about/about_action.dart';
import 'faq/faq_action.dart';

class ShareAppBar {
  final PaUser user;
  final bool isMobile;

  const ShareAppBar({required this.user, required this.isMobile});

  AppBar get() {
    return AppBar(
      title: const Text("PassAround", style: TextStyle(fontSize: 26)),
      actions: [
        const AboutAction(),
        const FaqAction(),
        const PrivacyPolicyAction(),
        ProfileAction(userId: user.id, username: user.username, isMobile: isMobile),
      ],
    );
  }
}
