import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/about_go_route.dart';
import 'package:passaround/widgets/empty.dart';

class AboutAction extends StatelessWidget {
  const AboutAction({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _navigateToAboutScreen(context),
              child: const Text("About"),
            ),
          )
        : const Empty();
  }

  void _navigateToAboutScreen(BuildContext context) {
    GoRouter.of(context).pushNamed(AboutGoRoute.name);
  }
}
