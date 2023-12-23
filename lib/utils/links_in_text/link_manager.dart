import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:passaround/utils/links_in_text/link_text.dart';
import 'package:passaround/utils/links_in_text/plain_text.dart';
import 'package:passaround/utils/links_in_text/textable.dart';

class LinkManager {
  static final RegExp _urlLinkRegExp = RegExp(
    r'(?:(?:https?:\/\/)?(?:www\.)?|(?:www\.)?)'
    r'(?:(?!www)[\w-]+\.)*(?:(?!www)[\w-]+)'
    r'(?:\.[a-z]{2,}){1,}(?:\/[^\s]*)?',
    caseSensitive: false,
    multiLine: false,
  );
  static final RegExp _markupLinkRegExp = RegExp(r'\[.*?\]\(.*?\)');

  final bool useMarkup;

  const LinkManager({this.useMarkup = false});

  List<Textable> getParts(String text) {
    final List<LinkText> linkParts = _getLinkParts(text);
    final List<PlainText> plainParts = _getPlainTextParts(text);
    final List<Textable> allParts = _getAllParts(plainParts: plainParts, linkParts: linkParts);
    return allParts;
  }

  List<LinkText> _getLinkParts(String text) {
    return useMarkup ? _getMarkupLinks(text) : _getUrlLinks(text);
  }

  List<LinkText> _getUrlLinks(String text) {
    List<String> matches = match(text);
    final List<LinkText> links = matches.map((m) => LinkText.fromUrl(m)).toList();
    return links;
  }

  List<LinkText> _getMarkupLinks(String text) {
    List<String> matches = match(text);
    final List<LinkText> links = matches.map((m) => LinkText.fromMarkup(m)).toList();
    return links;
  }

  @visibleForTesting
  List<String> match(String text) {
    final RegExp regExp = useMarkup ? _markupLinkRegExp : _urlLinkRegExp;
    return regExp.allMatches(text).map((m) => m.group(0).toString()).toList();
  }

  List<PlainText> _getPlainTextParts(String text) {
    const separator = '____';

    final RegExp regExp = useMarkup ? _markupLinkRegExp : _urlLinkRegExp;
    final String textWithReplacements = text.replaceAll(regExp, separator);
    final List<String> stringParts = textWithReplacements.split(separator);
    final List<PlainText> plainTextParts = stringParts.map((part) => PlainText(part)).toList();
    return plainTextParts;
  }

  static List<Textable> _getAllParts({
    required List<PlainText> plainParts,
    required List<LinkText> linkParts,
  }) {
    // code taken from https://stackoverflow.com/questions/54405066/how-to-merge-2-lists-in-dart
    var allParts = Iterable.generate(max(linkParts.length, plainParts.length)).expand((i) sync* {
      if (i < plainParts.length) yield plainParts[i];
      if (i < linkParts.length) yield linkParts[i];
    }).toList();
    allParts.removeWhere((element) => element.text == '');

    return allParts;
  }
}
