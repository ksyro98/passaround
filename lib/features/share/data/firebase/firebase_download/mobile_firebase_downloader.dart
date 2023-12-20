import 'package:url_launcher/url_launcher.dart';

import 'firebase_downloader.dart';

class MobileFirebaseDownloader implements FirebaseDownloader {
  final String _downloadUrl;

  const MobileFirebaseDownloader(this._downloadUrl);

  @override
  Future<bool> download() async {
    final Uri uri = Uri.parse(_downloadUrl);
    if(await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }
}
