import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:passaround/data_structures/extended_bool.dart';
import 'package:passaround/firebase/firebase_download/mobile_firebase_downloader_factory.dart'
    if (dart.library.html) 'package:passaround/firebase/firebase_download/web_firebase_downloader_factory.dart';
import 'package:passaround/firebase/firebase_id_manager.dart';

import '../../../../firebase/firebase_download/firebase_downloader_factory.dart';
import '../../../../utils/file_utils.dart';
import '../../../../utils/logger.dart';

class ShareStorage {
  final _storageRef = FirebaseStorage.instance.ref();

  Future<ExtendedBool> storeFile(Map<String, dynamic> data, {required bool isImage}) async {
    final String firebasePath = _getStoragePath(
      directories: [
        FirebaseIdManager.get().id,
        isImage ? "images" : "files",
      ],
      fileName: isImage ? data["ts"].toString() : FileUtils.getNameWithoutExtension(data["name"]),
      fileExtension: FileUtils.getExtension(data["name"]),
    );

    bool succeeded = false;
    if (data["path"] != null) {
      succeeded = await _storeFile(path: data["path"], firebasePath: firebasePath);
    } else if (data["bytes"] != null) {
      succeeded = await _storeData(bytes: data["bytes"], firebasePath: firebasePath);
    }

    return ExtendedBool(succeeded, detail: firebasePath);
  }

  String _getStoragePath({
    List<String?>? directories,
    required String fileName,
    required String fileExtension,
  }) {
    String directoryPath = directories?.nonNulls.join("/") ?? "";
    return "$directoryPath/$fileName.$fileExtension";
  }

  Future<bool> _storeFile({required String path, required String firebasePath}) async {
    return await _store(
      action: (ref) => ref.putFile(File(path)),
      firebasePath: firebasePath,
    );
  }

  Future<bool> _storeData({required Uint8List bytes, required String firebasePath}) async {
    return await _store(
      action: (ref) => ref.putData(bytes),
      firebasePath: firebasePath,
    );
  }

  Future<bool> _store({required Future<void> Function(Reference) action, required String firebasePath}) async {
    try {
      final userDir = _storageRef.child(firebasePath);
      await action(userDir);
      return true;
    } catch (e) {
      Logger.ePrint(e);
      return false;
    }
  }

  Future<String> getDownloadUrl(String path) async => await _storageRef.child(path).getDownloadURL();

  Future<int> getSize(String path) async {
    FullMetadata metadata = await _storageRef.child(path).getMetadata();
    return metadata.size ?? 0;
  }

  Future<void> delete(String path) async {
    await _storageRef.child(path).delete();
  }

  Future<bool> download({String? downloadUrl, String? storagePath}) async {
    final FirebaseDownloaderFactory d = ConcreteFirebaseDownloaderFactory(
      downloadUrl: downloadUrl,
      storagePath: storagePath,
    );
    return await d.download();
  }
}
