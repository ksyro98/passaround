import 'package:flutter/material.dart';

enum OnboardingCardDirection { left, right }

class OnboardingCard extends StatelessWidget {
  final String text;
  final int number;
  final OnboardingCardDirection direction;

  const OnboardingCard({
    super.key,
    required this.text,
    required this.number,
    required this.direction,
  });

  double get _rightPadding => direction == OnboardingCardDirection.left ? 80 : 12;
  double get _leftPadding => direction == OnboardingCardDirection.right ? 80 : 12;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32, right: _rightPadding, left: _leftPadding),
      child: SizedBox(
        // height: 80,
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 0,
          child: SizedBox(
            // height: 200,
            // width: 200,
            child: Row(
              children: [
                _firstItem(context),
                const SizedBox(width: 12),
                _secondItem(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _firstItem(BuildContext context) =>
      direction == OnboardingCardDirection.left ? _onboardingNumber(context) : _onboardingText(context);

  Widget _secondItem(BuildContext context) =>
      direction == OnboardingCardDirection.left ? _onboardingText(context) : _onboardingNumber(context);

  Widget _onboardingNumber(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        color: Theme.of(context).colorScheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(360),
          ),
        ),
        elevation: 0,
        child: SizedBox(
          height: 40,
          width: 40,
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  Widget _onboardingText(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
