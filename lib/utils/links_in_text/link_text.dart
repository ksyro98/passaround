import 'package:flutter/foundation.dart';
import 'package:passaround/utils/links_in_text/textable.dart';

@immutable
class LinkText implements Textable {
  final String _text;
  final String _href;

  @override
  String get text => _text;

  String get href => _href;

  const LinkText(this._text, this._href);

  const LinkText.fromUrl(String url)
      : _text = url,
        _href = url;

  factory LinkText.fromMarkup(String markupLink) {
    final List<String> parts = markupLink.split("](");
    final String text = parts[0].substring(1);
    final String href = parts[1].substring(0, parts[1].length - 1);
    return LinkText(text, href);
  }
}
