import 'package:flutter/foundation.dart';
import 'package:passaround/utils/links_in_text/textable.dart';

@immutable
class PlainText implements Textable {
  final String _text;

  @override
  String get text => _text;

  const PlainText(this._text);
}