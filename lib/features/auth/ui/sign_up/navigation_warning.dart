import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class NavigationWarning {
  static const _title = "Before you go";
  static const _content =
      "You haven't finished creating your account. Are you sure that you want to go to the Log In screen now?";
  static const _cancelActionText = "No, stay here";
  static const _confirmActionText = "Yes";

  final BuildContext context;
  final void Function() onConfirm;

  const NavigationWarning({required this.context, required this.onConfirm});

  void show() {
    final bool isIOS = !kIsWeb && Platform.isIOS;
    isIOS ? _showCupertinoDialog() : _showMaterialDialog();
  }

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: _getTitle(),
        content: _getContent(),
        actions: [
          TextButton(
            onPressed: _onCancelPressed,
            child: _getCancelActionText(),
          ),
          TextButton(
            onPressed: _onConfirmPressed,
            child: _getConfirmActionText(),
          ),
        ],
      ),
    );
  }

  void _showCupertinoDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: _getTitle(),
        content: _getContent(),
        actions: [
          CupertinoDialogAction(
            onPressed: _onCancelPressed,
            child: _getCancelActionText(),
          ),
          CupertinoDialogAction(
            onPressed: _onConfirmPressed,
            child: _getConfirmActionText(),
          ),
        ],
      ),
    );
  }

  Widget _getTitle() => const Text(_title);
  Widget _getContent() => const Text(_content);
  Widget _getCancelActionText() => const Text(_cancelActionText);
  void _onCancelPressed() => Navigator.pop(context, 'Cancel');
  Widget _getConfirmActionText() => const Text(_confirmActionText);
  void _onConfirmPressed() {
    Navigator.pop(context, 'OK');
    onConfirm();
  }
}
