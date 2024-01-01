import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../navigation/share_go_route.dart';

class BackArrow extends StatelessWidget {
  static const String _homeRouteName = ShareGoRoute.name;

  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _navigateBack(context),
      icon: const Icon(Icons.arrow_back),
    );
  }

  void _navigateBack(BuildContext context) {
    GoRouter.of(context).canPop() ? GoRouter.of(context).pop() : GoRouter.of(context).goNamed(_homeRouteName);
  }
}
