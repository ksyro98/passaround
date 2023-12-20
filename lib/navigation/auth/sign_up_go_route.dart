import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/auth/auth_extras.dart';
import 'package:passaround/features/auth/ui/sign_up/sign_up_screen.dart';

import '../navigation_base.dart';

class SignUpGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'signup';
  static const String path = '/signup';

  @override
  GoRoute get() => GoRoute(
        name: name,
        path: path,
        builder: (context, state) {
          AuthExtras? extras = state.extra as AuthExtras?;
          return SignUpScreen(
            username: extras?.username ?? "",
            email: extras?.email ?? "",
            password: extras?.password ?? "",
          );
        },
      );
}
