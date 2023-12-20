import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passaround/features/auth/bloc/auth_bloc.dart';
import 'package:passaround/features/auth/ui/common/auth_base_screen.dart';

class RecoverPasswordScreen extends StatelessWidget {
  final String email;

  const RecoverPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return AuthBaseScreen(
      authHeaderText: "Recover password",
      excludeUsernameField: true,
      excludePasswordField: true,
      includeRecoverPasswordText: false,
      includePasswordStrengthText: false,
      primaryButtonText: "Recover",
      onPrimaryButtonClick: ({
        String? username,
        required String email,
        required String password,
      }) =>
          context.read<AuthBloc>().add(AuthRecoverPassword(email)),
      startingEmail: email,
    );
  }
}
