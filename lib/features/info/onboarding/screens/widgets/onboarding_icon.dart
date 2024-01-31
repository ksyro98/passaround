import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingIcon extends StatelessWidget {
  final String assetName;

  const OnboardingIcon({super.key, required this.assetName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: 180,
      height: 180,
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn),
    );  }
}
