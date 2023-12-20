import 'package:flutter/foundation.dart';


@immutable
abstract class FirebaseDownloader {
  Future<bool> download();
}
