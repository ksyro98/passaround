import 'package:passaround/features/share/data/firebase/share_firestore.dart';
import 'package:passaround/features/share/data/firebase/share_storage.dart';
import 'package:passaround/features/share/data/share_remote_data_provider.dart';
import 'package:passaround/utils/constants.dart';

import '../../../../data_structures/either.dart';

class ShareFirebase implements ShareRemoteDataProvider {
  final ShareFirestore _firestore = ShareFirestore();
  final ShareStorage _storage = ShareStorage();

  @override
  Future<List<Map<String, dynamic>>?> getItems() async => await _firestore.getItems();

  @override
  Stream<List<Map<String, dynamic>>> newItemsStream() => _firestore.newItemsStream();

  @override
  Future<bool> writeTextItem(Map<String, dynamic> data) async => await _firestore.writeOnSharedCollection(data);

  @override
  Future<bool> writeImageOrFileItem(Map<String, dynamic> data, {required bool isImage}) async {
    final String firebasePath = _storage.getFirebasePath(ts: data["ts"], name: data["name"], isImage: isImage);

    final List<dynamic> details = await Future.wait([
      _storage.getDownloadUrl(firebasePath),
      _storage.getSize(firebasePath),
    ]);

    final String downloadUrl = details[0];
    final int size = details[1];

    return await _firestore.writeOnSharedCollection({
      "ts": data["ts"],
      "path": firebasePath,
      "downloadUrl": downloadUrl,
      "size": size,
      "type": isImage ? TypeValues.image : TypeValues.file,
    });
  }

  @override
  Stream<Either<String, double>> storeImage(Map<String, dynamic> data) => _storage.store(data, isImage: true);

  @override
  Stream<Either<String, double>> storeFile(Map<String, dynamic> data) => _storage.store(data, isImage: false);

  @override
  Future<bool> deleteItem(String id, {String? path}) async {
    final bool succeeded = await _firestore.deleteItem(id);

    if (path != null) {
      _storage.delete(path);
    }

    return succeeded;
  }

  @override
  Future<bool> download(Map<String, String> data) async => await _storage.download(
        downloadUrl: data["downloadUrl"],
        storagePath: data["storagePath"],
      );
}
