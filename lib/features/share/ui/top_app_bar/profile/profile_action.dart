import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/entities/pa_user_manager.dart';
import 'package:passaround/features/share/ui/top_app_bar/profile/profile_icon.dart';
import 'package:passaround/features/share/ui/top_app_bar/profile/profile_name_and_icon.dart';
import 'package:passaround/navigation/auth/log_in_go_route.dart';
import 'package:passaround/navigation/profile_go_route.dart';

class ProfileAction extends StatefulWidget {
  final String username;
  final String userId;
  final bool isMobile;

  const ProfileAction({super.key, required this.userId, required this.username, required this.isMobile});

  @override
  State<ProfileAction> createState() => _ProfileActionState();
}

class _ProfileActionState extends State<ProfileAction> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _navigateToUserDetails,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: widget.isMobile ? const ProfileIcon() : ProfileNameAndIcon(username: widget.username),
        ),
      ),
    );
  }

  void _navigateToUserDetails() {
    if (PaUserManager.get().isLoggedIn()) {
      GoRouter.of(context).pushNamed(ProfileGoRoute.name, pathParameters: {"id": widget.userId});
    } else {
      GoRouter.of(context).goNamed(LogInGoRoute.name);
    }
  }
}
