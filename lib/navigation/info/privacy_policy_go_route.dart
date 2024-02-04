import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/navigation_base.dart';

import '../../features/info/privacy_policy/privacy_policy_screen.dart';

class PrivacyPolicyGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'privacy';
  static const String path = '/privacy';

  @override
  GoRoute get() => GoRoute(name: name, path: path, builder: (context, state) => const PrivacyPolicyScreen());
}
