import 'package:flutter/foundation.dart';

import 'firebase_downloader.dart';

@immutable
abstract class FirebaseDownloaderFactory {
  final String downloadUrl;
  final String storagePath;

  const FirebaseDownloaderFactory({
    String? downloadUrl,
    String? storagePath,
  })  : downloadUrl = downloadUrl ?? "",
        storagePath = storagePath ?? "";

  FirebaseDownloader get();

  Future<bool> download() async {
    FirebaseDownloader downloader = get();
    return await downloader.download();
  }
}
