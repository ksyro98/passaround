import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passaround/utils/constants.dart';

class MobileFirstTimeStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> isFirstTime() async {
    final bool isNotFirstTime = await _storage.read(key: FlutterSecureStorageValues.firstTimeKey) == "false";
    return !isNotFirstTime;
  }

  Future<void> storeNotFirstTime() async =>
      await _storage.write(key: FlutterSecureStorageValues.firstTimeKey, value: "false");
}
