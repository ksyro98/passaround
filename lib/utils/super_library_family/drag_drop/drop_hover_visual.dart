import 'package:flutter/material.dart';

class DropHoverVisual extends StatelessWidget {
  final bool show;

  const DropHoverVisual({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: show ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Padding(
            padding: const EdgeInsets.only(right: 28),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Theme.of(context).colorScheme.primaryContainer.withAlpha(0x4C),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  child: Text(
                    "Drop Image or File to upload",
                    style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
