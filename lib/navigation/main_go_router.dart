import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/info/about_go_route.dart';
import 'package:passaround/navigation/auth/log_in_go_route.dart';
import 'package:passaround/navigation/image_go_route.dart';
import 'package:passaround/navigation/info/faq_go_route.dart';
import 'package:passaround/navigation/onboarding_go_route.dart';
import 'package:passaround/navigation/share_go_route.dart';
import 'package:passaround/navigation/auth/sign_up_go_route.dart';
import 'package:passaround/navigation/profile_go_route.dart';

import 'auth/recover_password_go_route.dart';
import 'auth/recovery_email_sent_go_route.dart';

class MainGoRouter {
  static const String _initialLocation = ShareGoRoute.path;

  GoRouter get() => GoRouter(
    initialLocation: _initialLocation,
    routes: [
      ShareGoRoute().get(),
      LogInGoRoute().get(),
      SignUpGoRoute().get(),
      RecoverPasswordGoRoute().get(),
      RecoveryEmailSentGoRoute().get(),
      ProfileGoRoute().get(),
      ImageGoRoute().get(),
      AboutGoRoute().get(),
      FaqGoRoute().get(),
      MobileGuideGoRoute().get(),
    ],
  );
}