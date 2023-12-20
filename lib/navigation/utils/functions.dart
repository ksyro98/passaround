import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/entities/pa_user_manager.dart';

import '../auth/log_in_go_route.dart';

void navigateAwayIfLoggedOut(BuildContext context) {
  final bool shouldGoToLogInScreen = !PaUserManager.get().isLoggedIn();
  if (shouldGoToLogInScreen) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).goNamed(LogInGoRoute.name);
    });
  }
}
