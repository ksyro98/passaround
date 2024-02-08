import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/info/about_go_route.dart';

class GetItOnMobileText extends StatelessWidget {
  const GetItOnMobileText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _navigateToAboutPage(context),
      child: const Text("Get it on your phone"),
    );
  }

  void _navigateToAboutPage(BuildContext context) => GoRouter.of(context).pushNamed(AboutGoRoute.name);
}
