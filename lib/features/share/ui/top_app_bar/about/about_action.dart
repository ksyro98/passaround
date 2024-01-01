import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/about_go_route.dart';
import 'package:passaround/widgets/empty.dart';

class AboutAction extends StatelessWidget {
  final bool isMobile;

  const AboutAction({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? const Empty()
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _navigateToAboutScreen(context),
              child: const Text("About"),
            ),
          );
  }

  void _navigateToAboutScreen(BuildContext context) {
    GoRouter.of(context).pushNamed(AboutGoRoute.name);
  }
}
