import '../../../data_structures/either.dart';

abstract class ShareRemoteDataProvider {
  Future<List<Map<String, dynamic>>?> getItems();

  Stream<List<Map<String, dynamic>>> newItemsStream();

  Future<bool> writeTextItem(Map<String, dynamic> data);

  Future<bool> writeImageOrFileItem(Map<String, dynamic> data, {required bool isImage});

  Stream<Either<String, double>> storeImage(Map<String, dynamic> data);

  Stream<Either<String, double>> storeFile(Map<String, dynamic> data);

  Future<bool> deleteItem(String id, {String? path});

  Future<bool> download(Map<String, String> data);
}