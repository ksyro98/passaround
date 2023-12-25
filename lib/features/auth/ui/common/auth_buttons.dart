import 'package:flutter/material.dart';

import 'auth_form_validator.dart';

class AuthButtons extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String primaryButtonText;
  final void Function() onPrimaryButtonClick;
  final String? secondaryButtonText;
  final String? secondaryButtonDescription;
  final void Function()? onSecondaryButtonClick;
  final bool areDisabled;

  const AuthButtons({
    super.key,
    required this.primaryButtonText,
    required this.onPrimaryButtonClick,
    this.formKey,
    this.secondaryButtonText,
    this.secondaryButtonDescription,
    this.onSecondaryButtonClick,
    this.areDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: areDisabled ? null : _validateAndAct,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(primaryButtonText),
          ),
        ),
        const SizedBox(height: 8),
        if (secondaryButtonDescription != null)
          Padding(
            padding: const EdgeInsets.only(top: 36, bottom: 4),
            child: Text(secondaryButtonDescription ?? ""),
          ),
        if (secondaryButtonText != null)
          OutlinedButton(
            onPressed: areDisabled ? null : onSecondaryButtonClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(secondaryButtonText ?? ""),
            ),
          ),
      ],
    );
  }

  void _validateAndAct() {
    final AuthFormValidator validator = AuthFormValidator(formKey);
    bool canAct = validator.validate();
    if (canAct) {
      onPrimaryButtonClick();
    }
  }
}
