import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants.dart';

class LogoCircular extends StatelessWidget {

  const LogoCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetValues.logoCircular,
      width: 100,
      height: 100,
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn),
    );
  }
}
