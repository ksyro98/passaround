// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'firebase_downloader.dart';

class WebFirebaseDownloader implements FirebaseDownloader {
  final String _downloadUrl;

  const WebFirebaseDownloader(this._downloadUrl);

  @override
  Future<bool> download() async {
    final html.AnchorElement anchor = html.AnchorElement(href: _downloadUrl)
      ..target = 'blank';
    anchor.click();
    return true;
  }

}