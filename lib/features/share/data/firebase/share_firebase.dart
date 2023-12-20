import 'package:passaround/data_structures/extended_bool.dart';
import 'package:passaround/features/share/data/firebase/share_firestore.dart';
import 'package:passaround/features/share/data/firebase/share_storage.dart';
import 'package:passaround/features/share/data/share_remote_data_provider.dart';

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
  Future<bool> writeImageItem(Map<String, dynamic> data) async {
    final ExtendedBool res = await _storage.storeFile(data, isImage: true);
    final bool succeeded = res.value;
    final String firebasePath = res.detail;
    final String downloadUrl = await _storage.getDownloadUrl(firebasePath);

    if (succeeded) {
      return await _firestore.writeOnSharedCollection({
        "ts": data["ts"],
        "imagePath": firebasePath,
        "downloadUrl": downloadUrl,
      });
    }
    return false;
  }

  @override
  Future<bool> writeFileItem(Map<String, dynamic> data) async {
    // get file from path
    // store file on Firebase Storage
    // get path from Storage (or sth equivalent)
    // store Storage path on Firestore
    // on success true, else false
    return false;
  }

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
