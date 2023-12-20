import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/auth/auth_extras.dart';
import 'package:passaround/features/auth/ui/log_in/log_in_screen.dart';

import '../navigation_base.dart';

class LogInGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'login';
  static const String path = '/login';

  @override
  GoRoute get() => GoRoute(name: name, path: path, builder: (context, state) {
    AuthExtras? extras = state.extra as AuthExtras?;
    return LogInScreen(email: extras?.email ?? "", password: extras?.password ?? "");
  });
}
