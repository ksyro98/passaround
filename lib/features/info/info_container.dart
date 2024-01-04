import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';
import '../../utils/form_factors_utils.dart';
import '../../widgets/back_arrow.dart';

class InfoContainer extends StatelessWidget {
  final Widget child;

  const InfoContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMediumScreen = FormFactorsUtils.isMediumScreen(constraints.maxWidth);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getBodyText(isMediumScreen),
              if (!isMediumScreen) _getAccompanyingLogo(context),
            ],
          );
        },
      ),
    );
  }

  Widget _getBodyText(bool isMediumScreen) {
    return Expanded(
      flex: 4,
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMediumScreen ? 24 : 120),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _getAccompanyingLogo(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 10),
        child: SvgPicture.asset(
          AssetValues.logoHalfBlackLarge,
          fit: BoxFit.fitWidth,
          clipBehavior: Clip.none,
          alignment: Alignment.centerRight,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
        ),
      ),
    );
  }
}
