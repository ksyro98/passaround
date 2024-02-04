import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../navigation/info/privacy_policy_go_route.dart';
import '../../../../../widgets/empty.dart';
import '../utils/text_action.dart';

class PrivacyPolicyAction extends StatelessWidget {
  const PrivacyPolicyAction({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? TextAction(text: "Privacy Policy", onTap: () => _navigateToFaqScreen(context)) : const Empty();
  }

  void _navigateToFaqScreen(BuildContext context) {
    GoRouter.of(context).pushNamed(PrivacyPolicyGoRoute.name);
  }
}
