import 'package:passaround/data_structures/extended_bool.dart';
import 'package:passaround/features/share/data/firebase/share_firestore.dart';
import 'package:passaround/features/share/data/firebase/share_storage.dart';
import 'package:passaround/features/share/data/share_remote_data_provider.dart';
import 'package:passaround/utils/constants.dart';

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
    return await _writeToStorage(data, isImage: true);
  }

  @override
  Future<bool> writeFileItem(Map<String, dynamic> data) async {
    return await _writeToStorage(data, isImage: false);
  }

  Future<bool> _writeToStorage(Map<String, dynamic> data, {required bool isImage}) async {
    final ExtendedBool res = await _storage.storeFile(data, isImage: isImage);
    final bool succeeded = res.value;
    final String firebasePath = res.detail;
    final List<dynamic> details = await Future.wait([
      _storage.getDownloadUrl(firebasePath),
      _storage.getSize(firebasePath),
    ]);

    final String downloadUrl = details[0];
    final int size = details[1];

    if (succeeded) {
      return await _firestore.writeOnSharedCollection({
        "ts": data["ts"],
        "path": firebasePath,
        "downloadUrl": downloadUrl,
        "size": size,
        "type": isImage ? TypeValues.image : TypeValues.file,
      });
    }
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
