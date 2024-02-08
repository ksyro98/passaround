import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/info/faq_go_route.dart';

import 'link_text_base.dart';

class LearnMoreText extends StatelessWidget {
  final double? fontSize;

  const LearnMoreText({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return LinkTextBase(
      text: "Learn more",
      onClick: () => _launchFaqScreen(context),
      fontSize: fontSize,
    );
  }

  Future<void> _launchFaqScreen(BuildContext context) async {
    // TODO change that when the new domain is used
    // const String faqUrl = "${ProjectValues.url}/faq?expanded=5";
    // final Uri uri = Uri.parse(faqUrl);
    // if(await canLaunchUrl(uri)) {
    //   launchUrl(uri);
    // }
    GoRouter.of(context).pushNamed(FaqGoRoute.name, queryParameters: {"expanded": "5"});
  }
}
