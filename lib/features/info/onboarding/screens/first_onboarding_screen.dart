import 'package:flutter/material.dart';
import 'package:passaround/features/info/onboarding/screens/widgets/onboarding_card.dart';
import 'package:passaround/features/info/onboarding/screens/widgets/onboarding_icon.dart';
import 'package:passaround/widgets/single_child_scroll_view_for_column.dart';

import '../../../../utils/constants.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollViewForColumn(
      padding: EdgeInsets.only(bottom: 64),
      column: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OnboardingCard(
            text: OnboardingValues.firstText,
            number: 1,
            direction: OnboardingCardDirection.left,
          ),
          OnboardingIcon(
            assetName: AssetValues.onboardingIcon1,
          ),
        ],
      ),
    );
  }
}
