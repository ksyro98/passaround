import 'package:passaround/firebase/firebase_download/web_firebase_downloader.dart';
import 'firebase_downloader.dart';
import 'firebase_downloader_factory.dart';

class ConcreteFirebaseDownloaderFactory extends FirebaseDownloaderFactory {
  const ConcreteFirebaseDownloaderFactory({
    String? downloadUrl,
    String? storagePath,
  }) : super(downloadUrl: downloadUrl, storagePath: storagePath);


  @override
  FirebaseDownloader get() => WebFirebaseDownloader(downloadUrl);
}

