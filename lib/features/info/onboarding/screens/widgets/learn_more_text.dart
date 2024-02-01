import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/info/faq_go_route.dart';

class LearnMoreText extends StatelessWidget {
  const LearnMoreText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _launchFaqScreen(context),
      child: const Text(
        "Learn more",
        style: TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Future<void> _launchFaqScreen(BuildContext context) async {
    // TODO change that when the new domain is used
    // const String faqUrl = "https://passaround-tcu.web.app/faq";
    // final Uri uri = Uri.parse(faqUrl);
    // if(await canLaunchUrl(uri)) {
    //   launchUrl(uri);
    // }
    GoRouter.of(context).pushNamed(FaqGoRoute.name);
  }
}
