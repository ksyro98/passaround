import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:passaround/utils/links_in_text/link_manager.dart';
import 'package:passaround/utils/links_in_text/link_text.dart';
import 'package:passaround/utils/links_in_text/textable.dart';

class LinkableText extends StatelessWidget {
  final String text;
  final void Function(String) onLinkPressed;
  final TextStyle? style;
  final TextStyle? plainTextStyle;
  final TextStyle? linkTextStyle;
  final bool isSelectable;
  final bool useMarkup;

  const LinkableText(
    this.text, {
    super.key,
    required this.onLinkPressed,
    this.style,
    this.plainTextStyle,
    this.linkTextStyle,
    this.isSelectable = true,
    this.useMarkup = false,
  });

  @override
  Widget build(BuildContext context) {
    return isSelectable ? SelectableText.rich(_child) : RichText(text: _child);
  }

  TextSpan get _child {
    final LinkManager linkManager = LinkManager(useMarkup: useMarkup);
    final List<Textable> parts = linkManager.getParts(text);
    return TextSpan(children: parts.map((part) => _getSpan(part)).toList(), style: style);
  }

  TextSpan _getSpan(Textable textable) {
    if (textable is LinkText) {
      return TextSpan(
        text: textable.text,
        style: linkTextStyle,
        recognizer: TapGestureRecognizer()..onTap = () => onLinkPressed(textable.href),
      );
    }
    return TextSpan(text: textable.text);
  }
}
