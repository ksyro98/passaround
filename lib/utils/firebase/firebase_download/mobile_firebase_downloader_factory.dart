import 'firebase_downloader.dart';
import 'firebase_downloader_factory.dart';
import 'mobile_firebase_downloader.dart';

class ConcreteFirebaseDownloaderFactory extends FirebaseDownloaderFactory {
  const ConcreteFirebaseDownloaderFactory({
    String? downloadUrl,
    String? storagePath,
  }) : super(downloadUrl: downloadUrl, storagePath: storagePath);


  @override
  FirebaseDownloader get() => MobileFirebaseDownloader(downloadUrl);
}

