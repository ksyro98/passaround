import 'package:flutter/material.dart';

class AuthFields extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool excludeUsernameField;
  final bool excludeEmailField;
  final bool excludePasswordField;
  final bool areDisabled;

  const AuthFields({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    this.excludeUsernameField = false,
    this.excludeEmailField = false,
    this.excludePasswordField = false,
    this.areDisabled = false,
  });

  @override
  State<AuthFields> createState() => _AuthFieldsState();
}

class _AuthFieldsState extends State<AuthFields> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!widget.excludeUsernameField)
          TextField(
            controller: widget.usernameController,
            maxLines: 1,
            keyboardType: TextInputType.name,
            enabled: !widget.areDisabled,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Username",
            ),
          ),
        const SizedBox(height: 24),
        if (!widget.excludeEmailField)
          TextField(
            controller: widget.emailController,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            enabled: !widget.areDisabled,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
            ),
          ),
        const SizedBox(height: 24),
        if (!widget.excludePasswordField)
          TextField(
            controller: widget.passwordController,
            maxLines: 1,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_isPasswordVisible,
            enabled: !widget.areDisabled,
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
    );
  }

  void _togglePasswordVisibility() => setState(() => _isPasswordVisible = !_isPasswordVisible);
}
