import 'package:go_router/go_router.dart';
import 'package:passaround/features/auth/ui/recover_password/recover_password_screen.dart';

import '../navigation_base.dart';
import 'auth_extras.dart';

class RecoverPasswordGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'recover';
  static const String path = '/recover';

  @override
  GoRoute get() => GoRoute(name: name, path: path, builder: (context, state) {
    AuthExtras? extras = state.extra as AuthExtras?;
    return RecoverPasswordScreen(email: extras?.email ?? "");
  });
}
