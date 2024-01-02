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
