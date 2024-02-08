import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

class OpenOnTheWebText extends StatelessWidget {
  const OpenOnTheWebText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _openWebApp,
      child: const Text("Open on the web"),
    );
  }

  Future<void> _openWebApp() async {
    final Uri uri = Uri.parse(ProjectValues.url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }
}
