import 'package:flutter/material.dart';

class SimpleBottomSheet extends BottomSheet {
  /// It is unclear if [onClosing] is working
  static void showModal(BuildContext context, {required Widget child, void Function()? onClosing}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        builder: (context) => SimpleBottomSheet(
          onClosing: onClosing ?? () {},
          child: child,
        ),
      );
    });
  }

  /// It is unclear if [onClosing] is working
  static void showPersistent(BuildContext context, {required Widget child, void Function()? onClosing}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaffold.of(context).showBottomSheet(
        (context) => SimpleBottomSheet(
          onClosing: onClosing ?? () {},
          child: child,
        ),
      );
    });
  }

  static Widget _getSheetLayout(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: SingleChildScrollView(child: child),
    );
  }

  SimpleBottomSheet({
    super.key,
    required Widget child,
    required void Function() onClosing,
  }) : super(
          builder: (context) => _getSheetLayout(child),
          onClosing: onClosing,
          enableDrag: false,
        );
}
