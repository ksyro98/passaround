import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:passaround/data_structures/either.dart';
import 'package:passaround/utils/firebase/firebase_download/mobile_firebase_downloader_factory.dart'
    if (dart.library.html) 'package:passaround/firebase/firebase_download/web_firebase_downloader_factory.dart';
import 'package:passaround/utils/firebase/firebase_id_manager.dart';

import '../../../../utils/firebase/firebase_download/firebase_downloader_factory.dart';
import '../../../../utils/file_utils.dart';
import '../../../../utils/logger.dart';

class ShareStorage {
  final _storageRef = FirebaseStorage.instance.ref();

  String getFirebasePath({required int ts, required String name, required bool isImage}) => _getStoragePath(
        directories: [
          FirebaseIdManager.get().id,
          isImage ? "images" : "files",
        ],
        fileName: isImage ? ts.toString() : FileUtils.getNameWithoutExtension(name),
        fileExtension: FileUtils.getExtension(name),
      );

  Stream<Either<String, double>> store(Map<String, dynamic> data, {required bool isImage}) {
    final String firebasePath = getFirebasePath(ts: data["ts"], name: data["name"], isImage: isImage);

    if (data["path"] != null) {
      return _storeFile(path: data["path"], firebasePath: firebasePath);
    } else if (data["bytes"] != null) {
      return _storeData(bytes: data["bytes"], firebasePath: firebasePath);
    } else {
      return Stream.fromIterable([const Either.firstOnly("error")]);
    }
  }

  String _getStoragePath({
    List<String?>? directories,
    required String fileName,
    required String fileExtension,
  }) {
    String directoryPath = directories?.nonNulls.join("/") ?? "";
    return "$directoryPath/$fileName.$fileExtension";
  }

  Stream<Either<String, double>> _storeFile({required String path, required String firebasePath}) {
    return _store(
      action: (ref) => ref.putFile(File(path)),
      firebasePath: firebasePath,
    );
  }

  Stream<Either<String, double>> _storeData({required Uint8List bytes, required String firebasePath}) {
    return _store(
      action: (ref) => ref.putData(bytes),
      firebasePath: firebasePath,
    );
  }

  Stream<Either<String, double>> _store(
      {required UploadTask Function(Reference) action, required String firebasePath}) {
    try {
      final userDir = _storageRef.child(firebasePath);
      final UploadTask task = action(userDir);

      return task.snapshotEvents.map(
        (taskSnapshot) {
          final double progress = (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes).clamp(0, 0.99);
          return taskSnapshot.state == TaskState.success ? const Either.secondOnly(1) : Either.secondOnly(progress);
        },
      );
    } catch (e) {
      Logger.ePrint(e);
      return Stream.fromIterable([Either.firstOnly(e.toString())]);
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
