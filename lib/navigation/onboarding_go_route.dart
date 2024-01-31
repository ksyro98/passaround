import 'package:go_router/go_router.dart';
import 'package:passaround/features/info/onboarding/screens/onboarding_screens.dart';

import 'navigation_base.dart';

class MobileGuideGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'guide';
  static const String path = '/guide';

  @override
  GoRoute get() => GoRoute(
    name: name,
    path: path,
    builder: (context, state) => const OnboardingScreens(),
  );
}
