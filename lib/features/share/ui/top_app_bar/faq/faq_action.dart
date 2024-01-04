import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/info/faq_go_route.dart';

import '../../../../../widgets/empty.dart';
import '../utils/text_action.dart';

class FaqAction extends StatelessWidget {
  const FaqAction({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? TextAction(text: "FAQ", onTap: () => _navigateToFaqScreen(context)) : const Empty();
  }

  void _navigateToFaqScreen(BuildContext context) {
    GoRouter.of(context).pushNamed(FaqGoRoute.name);
  }
}
