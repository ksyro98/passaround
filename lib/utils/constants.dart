import 'package:flutter/material.dart';

class FormFactorValues {
  static const int smallScreenThreshold = 620;
  static const int mediumScreenThreshold = 800;
}

class ColorValues {
  static const Color mainColor = Color(0xfffd7900);
}

class AssetValues {
  static const String logoCircular = 'assets/logo_circular.svg';
  static const String logoHalfBlackLarge = 'assets/logo_large_half_black.svg';
  static const String googlePlayBadge = 'assets/google_play_badge.png';
  static const String onboardingIcon1 = 'assets/onboarding_icon_1.svg';
  static const String onboardingIcon2 = 'assets/onboarding_icon_2.svg';
  static const String onboardingIcon3 = 'assets/onboarding_icon_3.svg';
}

class TypeValues {
  static const String image = 'image';
  static const String file = 'file';
}

class AuthValues {
  static final RegExp emailRegExp = RegExp(r"^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$");
}

class NativeValues {
  static const int androidApi12LVersionCode = 32;
}

class FlutterSecureStorageValues {
  static const String firstTimeKey = "firstTimeKey";
}

class OnboardingValues {
  static const String firstText = "Create an account";
  static const String secondText = "Send any text, image, or file";
  static const String thirdText = "Log in from another device and access them";
}
