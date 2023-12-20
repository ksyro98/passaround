import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  final String primaryButtonText;
  final void Function() onPrimaryButtonClick;
  final String? secondaryButtonText;
  final void Function()? onSecondaryButtonClick;
  final bool areDisabled;

  const AuthButtons({
    super.key,
    required this.primaryButtonText,
    required this.onPrimaryButtonClick,
    this.secondaryButtonText,
    this.onSecondaryButtonClick,
    this.areDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: areDisabled ? null : onPrimaryButtonClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(primaryButtonText),
          ),
        ),
        const SizedBox(height: 8),
        if (secondaryButtonText != null)
          TextButton(
            onPressed: areDisabled ? null : onSecondaryButtonClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(secondaryButtonText ?? ""),
            ),
          ),
      ],
    );
  }

  Widget _getProgressIndicator(BuildContext context) => SizedBox(
        width: 14,
        height: 14,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );
}
