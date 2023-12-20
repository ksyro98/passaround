import 'package:go_router/go_router.dart';

import '../../features/auth/ui/recover_password/recovery_email_sent_screen.dart';
import '../navigation_base.dart';
import 'auth_extras.dart';

class RecoveryEmailSentGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'recovery-email-sent';
  static const String path = '/recover/sent';

  @override
  GoRoute get() => GoRoute(name: name, path: path, builder: (context, state) {
    AuthExtras? extras = state.extra as AuthExtras?;
    return RecoveryEmailSentScreen(email: extras?.email ?? "");
  });
}
