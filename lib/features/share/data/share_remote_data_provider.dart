abstract class ShareRemoteDataProvider {
  Future<List<Map<String, dynamic>>?> getItems();

  Stream<List<Map<String, dynamic>>> newItemsStream();

  Future<bool> writeTextItem(Map<String, dynamic> data);

  Future<bool> writeImageItem(Map<String, dynamic> data);

  Future<bool> writeFileItem(Map<String, dynamic> data);

  Future<bool> deleteItem(String id, {String? path});

  Future<bool> download(Map<String, String> data);
}