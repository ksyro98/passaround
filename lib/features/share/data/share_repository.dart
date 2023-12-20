
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/entities/image_item.dart';
import 'package:passaround/entities/item.dart';
import 'package:passaround/entities/text_item.dart';
import 'package:passaround/features/share/bloc/share_data_access.dart';

import '../../../entities/file_item.dart';
import 'share_remote_data_provider.dart';

class ShareRepository implements ShareDataAccess {
  final ShareRemoteDataProvider _remoteDataProvider;

  ShareRepository(this._remoteDataProvider);

  @override
  Future<List<Item>?> getItems() async {
    List<Map<String, dynamic>>? itemData = await _remoteDataProvider.getItems();
    List<Item>? items = itemData?.map((itemData) => _transformToItem(itemData)).nonNulls.toList();

    return items;
  }

  @override
  Stream<List<Item>> newItemsStream() {
    return _remoteDataProvider.newItemsStream().map((maps) => maps.map((e) => _transformToItem(e)).nonNulls.toList());
  }

  Item? _transformToItem(Map<String, dynamic> data) {
    if (data.containsKey("text")) {
      return TextItem.fromMap(data);
    } else if (data.containsKey("imagePath")) {
      return ImageItem.fromMap(data);
    } else if (data.containsKey("filePath")) {
      return FileItem.fromMap(data);
    } else {
      return null;
    }
  }

  @override
  Future<bool> writeTextItem(String text) async {
    final Map<String, dynamic> data = {
      "text": text,
      "ts": DateTime.now().millisecondsSinceEpoch,
    };
    return await _remoteDataProvider.writeTextItem(data);
  }

  @override
  Future<bool> writeImageItem(FileInfo fileInfo) async {
    final Map<String, dynamic> data = {
      "name": fileInfo.name,
      "path": fileInfo.path,
      "bytes": fileInfo.bytes,
      "ts": DateTime.now().millisecondsSinceEpoch,
    };
    return await _remoteDataProvider.writeImageItem(data);
  }

  @override
  Future<bool> writeFileItem(FileInfo fileInfo) async {
    final Map<String, dynamic> data = {
      "path": fileInfo.path,
      "ts": DateTime.now().millisecondsSinceEpoch,
    };
    return await _remoteDataProvider.writeFileItem(data);
  }

  @override
  Future<bool> deleteItem(Item item) async {
    String? path;
    if (item is ImageItem) {
      path = item.imagePath;
    } else if (item is FileItem) {
      path = item.filePath;
    }
    return await _remoteDataProvider.deleteItem(item.id, path: path);
  }

  @override
  Future<bool> download(Item item) async {
    if (item is ImageItem) {
      Map<String, String> data = {
        "downloadUrl": item.imageUrl,
        "storagePath": item.imagePath,
      };
      return await _remoteDataProvider.download(data);
    }
    return false;
  }
}
