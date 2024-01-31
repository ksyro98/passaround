import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/features/info/onboarding/mobile_first_time_storage.dart';
import 'package:passaround/navigation/onboarding_go_route.dart';
import 'package:passaround/widgets/logo_circular.dart';
import 'package:passaround/widgets/simple_bottom_sheet.dart';

class OnboardingSheet {
  final BuildContext _context;

  const OnboardingSheet(this._context);

  Future<void> showIfNeeded() async {
    if (await _isNeeded()) {
      // Do not use BuildContexts across async gaps: https://dart.dev/tools/linter-rules/use_build_context_synchronously
      if (!_context.mounted) return;
      _show(_context);

      await _updateStorage();
    }
  }

  Future<bool> _isNeeded() async {
    const bool isMobile = !kIsWeb;
    final bool isFirstTime = await MobileFirstTimeStorage().isFirstTime();
    return isMobile && isFirstTime;
  }

  void _show(BuildContext context) {
    SimpleBottomSheet.showModal(
      context,
      child: _startingInfo,
    );
  }

  Future<void> _updateStorage() async => MobileFirstTimeStorage().storeNotFirstTime();

  Widget get _startingInfo {
    return Column(
      children: [
        const Text("Welcome to PassAround", style: TextStyle(fontSize: 22)),
        const SizedBox(height: 6),
        const Text("We're so glad you're here", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 24),
        const LogoCircular(),
        const SizedBox(height: 30),
        FilledButton(onPressed: _navigateToGuideScreens, child: const Text("Show me how it works")),
        TextButton(onPressed: _closeSheet, child: const Text("Skip (I'll figure it out)")),
      ],
    );
  }

  void _navigateToGuideScreens() {
    Navigator.of(_context).pop();
    GoRouter.of(_context).pushNamed(MobileGuideGoRoute.name);
  }

  void _closeSheet() => Navigator.of(_context).pop();
}
