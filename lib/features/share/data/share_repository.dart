import 'package:passaround/data_structures/either.dart';
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/entities/image_item.dart';
import 'package:passaround/entities/item.dart';
import 'package:passaround/entities/text_item.dart';
import 'package:passaround/features/share/bloc/share_data_access.dart';
import 'package:passaround/utils/constants.dart';

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
    } else if (data.containsKey("type") && data["type"] == TypeValues.image) {
      return ImageItem.fromMap(data);
    } else if (data.containsKey("type") && data["type"] == TypeValues.file) {
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
  Stream<Either<String, double>> writeImageItem(FileInfo fileInfo) {
    final Map<String, dynamic> data = {
      "name": fileInfo.name,
      "path": fileInfo.path,
      "bytes": fileInfo.bytes,
      "ts": fileInfo.tsLoaded,
    };
    return _remoteDataProvider.storeImage(data);
  }

  @override
  Stream<Either<String, double>> writeFileItem(FileInfo fileInfo) {
    final Map<String, dynamic> data = {
      "name": fileInfo.name,
      "path": fileInfo.path,
      "bytes": fileInfo.bytes,
      "ts": fileInfo.tsLoaded,
    };
    return _remoteDataProvider.storeFile(data);
  }

  @override
  Future<bool> writeFileInfo(FileInfo fileInfo) async {
    final Map<String, dynamic> data = {
      "name": fileInfo.name,
      "path": fileInfo.path,
      "bytes": fileInfo.bytes,
      "ts": fileInfo.tsLoaded,
    };
    return await _remoteDataProvider.writeImageOrFileItem(data, isImage: fileInfo.isImage);
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
    } else if (item is FileItem) {
      Map<String, String> data = {
        "downloadUrl": item.fileUrl,
        "storagePath": item.filePath,
      };
      return await _remoteDataProvider.download(data);
    }
    return false;
  }
}
