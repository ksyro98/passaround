import 'package:passaround/features/share/data/firebase/firebase_download/firebase_downloader_factory.dart';
import 'package:passaround/features/share/data/firebase/firebase_download/firebase_downloader.dart';
import 'package:passaround/features/share/data/firebase/firebase_download/mobile_firebase_downloader.dart';

class ConcreteFirebaseDownloaderFactory extends FirebaseDownloaderFactory {
  const ConcreteFirebaseDownloaderFactory({
    String? downloadUrl,
    String? storagePath,
  }) : super(downloadUrl: downloadUrl, storagePath: storagePath);


  @override
  FirebaseDownloader get() => MobileFirebaseDownloader(downloadUrl);
}

