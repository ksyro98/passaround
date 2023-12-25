import 'package:flutter/material.dart';
import 'package:passaround/features/auth/ui/common/auth_form_validator.dart';
import 'package:passaround/utils/constants.dart';

class AuthFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool excludeUsernameField;
  final bool excludeEmailField;
  final bool excludePasswordField;
  final bool areDisabled;
  final void Function()? onEnterPressedAtPassword;

  const AuthFields({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    this.excludeUsernameField = false,
    this.excludeEmailField = false,
    this.excludePasswordField = false,
    this.areDisabled = false,
    this.onEnterPressedAtPassword,
  });

  @override
  State<AuthFields> createState() => _AuthFieldsState();
}

class _AuthFieldsState extends State<AuthFields> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          if (!widget.excludeUsernameField)
            TextFormField(
              controller: widget.usernameController,
              maxLines: 1,
              keyboardType: TextInputType.name,
              enabled: !widget.areDisabled,
              validator: _usernameValidation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username",
              ),
            ),
          const SizedBox(height: 24),
          if (!widget.excludeEmailField)
            TextFormField(
              controller: widget.emailController,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              enabled: !widget.areDisabled,
              validator: _emailValidation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
          const SizedBox(height: 24),
          if (!widget.excludePasswordField)
            TextFormField(
              controller: widget.passwordController,
              maxLines: 1,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isPasswordVisible,
              enabled: !widget.areDisabled,
              validator: _passwordValidation,
              onFieldSubmitted: _onPasswordSubmitted,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: _isPasswordVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String? _usernameValidation(String? value) {
    if (!widget.excludeUsernameField && (value == null || value.isEmpty)) {
      return "This field is required";
    }
    return null;
  }

  String? _emailValidation(String? value) {
    if (!widget.excludeEmailField && (value == null || value.isEmpty)) {
      return "This field is required";
    } else if (!widget.excludeEmailField && value != null && !AuthValues.emailRegExp.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  void _togglePasswordVisibility() => setState(() => _isPasswordVisible = !_isPasswordVisible);

  void _onPasswordSubmitted(String? value) {
    if (widget.onEnterPressedAtPassword != null) {
      final AuthFormValidator validator = AuthFormValidator(widget.formKey);
      bool isValid = validator.validate();
      if(isValid) {
        widget.onEnterPressedAtPassword!();
      }
    }
  }

  String? _passwordValidation(String? value) {
    if (!widget.excludePasswordField && (value == null || value.isEmpty)) {
      return "This field is required";
    } else if (!widget.excludePasswordField && value != null && value.length < 6) {
      return "The password is too short";
    }
    return null;
  }
}
