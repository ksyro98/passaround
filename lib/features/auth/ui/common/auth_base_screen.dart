import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/features/auth/bloc/auth_bloc.dart';
import 'package:passaround/features/auth/ui/common/auth_buttons.dart';
import 'package:passaround/features/auth/ui/common/auth_header_text.dart';
import 'package:passaround/features/auth/ui/sign_up/password_strength_text.dart';
import 'package:passaround/navigation/auth/auth_extras.dart';
import 'package:passaround/navigation/auth/recover_password_go_route.dart';
import 'package:passaround/navigation/auth/recovery_email_sent_go_route.dart';
import 'package:passaround/navigation/share_go_route.dart';
import 'package:passaround/widgets/simple_snack_bar.dart';

import '../../../../widgets/logo_circular.dart';
import '../log_in/recover_password_text.dart';
import 'auth_fields.dart';

class AuthBaseScreen extends StatefulWidget {
  final String authHeaderText;
  final bool excludeUsernameField;
  final bool excludeEmailField;
  final bool excludePasswordField;
  final bool includeRecoverPasswordText;
  final bool includePasswordStrengthText;
  final String primaryButtonText;
  final void Function({String? username, required String email, required String password}) onPrimaryButtonClick;
  final String? secondaryButtonText;
  final String? secondaryButtonDescription;
  final void Function({String? username, required String email, required String password})? onSecondaryButtonClick;
  final String startingUsername;
  final String startingEmail;
  final String startingPassword;

  const AuthBaseScreen({
    super.key,
    required this.authHeaderText,
    this.excludeUsernameField = false,
    this.excludeEmailField = false,
    this.excludePasswordField = false,
    required this.includeRecoverPasswordText,
    required this.includePasswordStrengthText,
    required this.primaryButtonText,
    required this.onPrimaryButtonClick,
    this.secondaryButtonText,
    this.secondaryButtonDescription,
    this.onSecondaryButtonClick,
    this.startingUsername = "",
    this.startingEmail = "",
    this.startingPassword = "",
  });

  @override
  State<AuthBaseScreen> createState() => _AuthBaseScreenState();
}

class _AuthBaseScreenState extends State<AuthBaseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.startingUsername;
    _emailController.text = widget.startingEmail;
    _passwordController.text = widget.startingPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.value == AuthStateValue.error) {
                  SimpleSnackBar.show(context, state.error);
                } else if (state.value == AuthStateValue.loggedIn) {
                  _navigateToShareScreen();
                } else if (state.value == AuthStateValue.recoveryEmailSent) {
                  _navigateToRecoveryEmailSentScreen();
                }
              },
              builder: (context, state) {
                final bool disableButtons = state.value == AuthStateValue.loading;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const LogoCircular(),
                    const SizedBox(height: 24),
                    AuthHeaderText(widget.authHeaderText),
                    const SizedBox(height: 10),
                    AuthFields(
                      formKey: _formKey,
                      usernameController: _usernameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      excludeUsernameField: widget.excludeUsernameField,
                      excludeEmailField: widget.excludeEmailField,
                      excludePasswordField: widget.excludePasswordField,
                      onEnterPressedAtPassword: () => widget.onPrimaryButtonClick(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (widget.includeRecoverPasswordText)
                      RecoverPasswordText(onPress: _navigateToRecoverPasswordScreen),
                    if (widget.includePasswordStrengthText) const PasswordStrengthText(),
                    const SizedBox(height: 12),
                    AuthButtons(
                      formKey: _formKey,
                      primaryButtonText: widget.primaryButtonText,
                      onPrimaryButtonClick: () => widget.onPrimaryButtonClick(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                      secondaryButtonText: widget.secondaryButtonText,
                      secondaryButtonDescription: widget.secondaryButtonDescription,
                      onSecondaryButtonClick: () {
                        if (widget.onSecondaryButtonClick != null) {
                          widget.onSecondaryButtonClick!(
                            username: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      areDisabled: disableButtons,
                    ),
                    // const SizedBox(height: 80),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToShareScreen() {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    GoRouter.of(context).goNamed(ShareGoRoute.name);
  }

  void _navigateToRecoverPasswordScreen() {
    GoRouter.of(context).pushNamed(
      RecoverPasswordGoRoute.name,
      extra: AuthExtras(email: _emailController.text, password: ""),
    );
  }

  void _navigateToRecoveryEmailSentScreen() {
    GoRouter.of(context).goNamed(
      RecoveryEmailSentGoRoute.name,
      extra: AuthExtras(email: _emailController.text, password: ""),
    );
  }
}
