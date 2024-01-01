import 'package:passaround/utils/constants.dart';

class FormFactorsUtils {
  static bool isSmallScreen(double maxWidth) => maxWidth <= FormFactorValues.smallScreenThreshold;
  static bool isMediumScreen(double maxWidth) => maxWidth <= FormFactorValues.mediumScreenThreshold;
}