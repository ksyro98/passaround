import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/features/auth/bloc/auth_bloc.dart';
import 'package:passaround/features/auth/ui/common/auth_base_screen.dart';
import 'package:passaround/navigation/auth/sign_up_go_route.dart';

import '../../../../navigation/auth/auth_extras.dart';

class LogInScreen extends StatefulWidget {
  final String email;
  final String password;

  const LogInScreen({super.key, required this.email, required this.password});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthBaseScreen(
      authHeaderText: "Connect to your account!",
      excludeUsernameField: true,
      includeRecoverPasswordText: true,
      includePasswordStrengthText: false,
      primaryButtonText: "Log In",
      onPrimaryButtonClick: _logIn,
      secondaryButtonText: "Sign Up",
      secondaryButtonDescription: "Don't have an account yet?",
      onSecondaryButtonClick: _navigateToSignUpScreen,
      startingEmail: widget.email,
      startingPassword: widget.password,
    );
  }

  void _logIn({
    String? username,
    required String email,
    required String password,
  }) =>
      context.read<AuthBloc>().add(AuthLogIn(email, password));

  void _navigateToSignUpScreen({
    String? username,
    required String email,
    required String password,
  }) =>
      GoRouter.of(context).pushNamed(
        SignUpGoRoute.name,
        extra: AuthExtras(email: email, password: password),
      );
}
