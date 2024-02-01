import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaround/features/info/info_container.dart';
import 'package:passaround/utils/constants.dart';
import 'package:passaround/widgets/simple_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return InfoContainer(child: _getBodyText());
  }

  Widget _getBodyText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: "Welcome to\n", style: TextStyle(fontSize: 40)),
              TextSpan(
                text: "PassAround",
                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 48),
              ),
            ],
          ),
          style: const TextStyle(height: 1),
        ),
        const SizedBox(height: 40),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: "The simplest way to "),
              TextSpan(text: "transfer", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              const TextSpan(text: " text and files between your devices."),
            ],
          ),
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 40),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: "Simply create an account and start sending "),
              TextSpan(text: "text", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              const TextSpan(text: ", "),
              TextSpan(text: "images", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              const TextSpan(text: ", or "),
              TextSpan(text: "files", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              const TextSpan(text: ". Then, log in on any device and access them from there."),
            ],
          ),
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 40),
        const Text(
          "You can use it on the web (you’re already here!), or download the mobile application.",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 12),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _launchGooglePlay,
                child: Image.asset(
                  AssetValues.googlePlayBadge,
                  width: 180,
                ),
              ),
            ),
            const SizedBox(width: 32),
            const Text(
              "Coming soon on\nApp Store",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 80),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "PassAround is open source!",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 12),
            _getGithubLogo(),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _getGithubLogo() {
    final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchGithub,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: SizedBox(
            height: 26,
            width: 26,
            child: SvgPicture.asset(
              isDarkMode ? AssetValues.githubWhiteLogo : AssetValues.githubBlackLogo,
            ),
          ),
        ),
      ),
    );
  }

  void _launchGooglePlay() {
    SimpleSnackBar.show(context, "Coming very soon...");
  }

  Future<void> _launchGithub() async {
    final Uri uri = Uri.parse(UrlValues.githubLink);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }
}
