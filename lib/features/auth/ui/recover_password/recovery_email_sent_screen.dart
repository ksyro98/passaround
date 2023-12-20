import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/features/auth/ui/common/auth_buttons.dart';
import 'package:passaround/navigation/auth/auth_extras.dart';
import 'package:passaround/navigation/auth/log_in_go_route.dart';

import '../../../../widgets/logo_circular.dart';

class RecoveryEmailSentScreen extends StatelessWidget {
  final String email;

  const RecoveryEmailSentScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                const LogoCircular(),
                const SizedBox(height: 4),
                const Text("Recovery email sent!", style: TextStyle(fontSize: 24)),
                const SizedBox(height: 36),
                AuthButtons(
                  primaryButtonText: "Log In",
                  onPrimaryButtonClick: () => _navigateToLogInScreen(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLogInScreen(BuildContext context) {
    while(GoRouter.of(context).canPop()){
      GoRouter.of(context).pop();
    }
    GoRouter.of(context).goNamed(LogInGoRoute.name, extra: AuthExtras(email: email, password: ""));
  }
}
