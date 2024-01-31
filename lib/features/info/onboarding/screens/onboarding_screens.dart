import 'package:flutter/material.dart';
import 'package:passaround/features/info/onboarding/screens/first_onboarding_screen.dart';
import 'package:passaround/features/info/onboarding/screens/second_onboarding_screen.dart';
import 'package:passaround/features/info/onboarding/screens/third_onboarding_screen.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  static const int _firstScreenIndex = 0;
  static const int _lastScreenIndex = 2;

  final PageController _controller = PageController();
  int get _currentScreenIndex {
    if (_controller.hasClients) {
      return _controller.page?.round() ?? 0;
    }
    return 0;
  }

  bool get _isFirstScreen => _currentScreenIndex == _firstScreenIndex;
  bool get _isLastScreen => _currentScreenIndex == _lastScreenIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screen,
          Align(
            alignment: Alignment.bottomCenter,
            child: _stepper,
          ),
        ],
      ),
    );
  }

  Widget get _screen {
    return Padding(
      padding: const EdgeInsets.only(top: 64, bottom: 64),
      child: PageView(
        controller: _controller,
        onPageChanged: (value) => setState(() {}),
        children: const [
          FirstOnboardingScreen(),
          SecondOnboardingScreen(),
          ThirdOnboardingScreen(),
        ],
      ),
    );
  }

  Widget get _stepper {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _isFirstScreen ? null : _moveBack,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          _counterDots,
          IconButton(
            onPressed: _isLastScreen ? _exitScreens : _moveForward,
            icon: Icon(_isLastScreen ? Icons.check : Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  Widget get _counterDots {
    return Row(
      children: List<int>.generate(_lastScreenIndex - _firstScreenIndex + 1, (index) => _firstScreenIndex + index)
          .map(
            (index) => Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: index == _currentScreenIndex
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  borderRadius: const BorderRadius.all(Radius.circular(360)),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void _moveBack() {
    if (_currentScreenIndex > _firstScreenIndex) {
      _controller.jumpToPage(_currentScreenIndex - 1);
    }
  }

  void _moveForward() {
    if (_currentScreenIndex < _lastScreenIndex) {
      _controller.jumpToPage(_currentScreenIndex + 1);
    }
  }

  void _exitScreens() => Navigator.of(context).pop();
}
