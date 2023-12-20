import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LogoCircular extends StatelessWidget {
  final String _lightThemeLogo = AssetValues.lightThemeCircularLogo;
  final String _darkThemeLogo = AssetValues.darkThemeCircularLogo;

  const LogoCircular({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final String imagePath = isDarkTheme ? _darkThemeLogo : _lightThemeLogo;
    return Image.asset(imagePath, width: 120, height: 120);
  }
}
