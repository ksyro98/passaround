import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../entities/pa_user.dart';
import '../auth/log_in_go_route.dart';

void navigateAwayIfLoggedOut(BuildContext context) {
  final bool shouldGoToLogInScreen = PaUser.instance == null;
  if (shouldGoToLogInScreen) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).goNamed(LogInGoRoute.name);
    });
  }
}
