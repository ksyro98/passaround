import 'package:flutter/material.dart';
import 'package:passaround/features/info/onboarding/screens/widgets/onboarding_card.dart';
import 'package:passaround/features/info/onboarding/screens/widgets/onboarding_icon.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/single_child_scroll_view_for_column.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollViewForColumn(
      padding: EdgeInsets.only(bottom: 64),
      column: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              OnboardingCard(
                text: OnboardingValues.firstText,
                number: 1,
                direction: OnboardingCardDirection.left,
              ),
              OnboardingCard(
                text: OnboardingValues.secondText,
                number: 2,
                direction: OnboardingCardDirection.right,
              ),
            ],
          ),
          OnboardingIcon(
            assetName: AssetValues.onboardingIcon2,
          ),
        ],
      ),
    );
  }
}
