import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/auth/auth_extras.dart';

import '../../../../navigation/auth/log_in_go_route.dart';
import '../../bloc/auth_bloc.dart';
import '../common/auth_base_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  const SignUpScreen({super.key, required this.username, required this.email, required this.password});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthBaseScreen(
      authHeaderText: "Create an account!",
      includeRecoverPasswordText: false,
      includePasswordStrengthText: true,
      primaryButtonText: "Sign Up",
      onPrimaryButtonClick: _signUp,
      secondaryButtonText: "Log In",
      onSecondaryButtonClick: _navigateToLogInScreen,
      startingEmail: widget.email,
      startingPassword: widget.password,
    );
  }

  void _signUp({
    String? username,
    required String email,
    required String password,
  }) =>
      context.read<AuthBloc>().add(AuthSignUp(username ?? "", email, password));

  void _navigateToLogInScreen({
    String? username,
    required String email,
    required String password,
  }) =>
      GoRouter.of(context).pushNamed(
        LogInGoRoute.name,
        extra: AuthExtras(email: email, password: password),
      );
}
