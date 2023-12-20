
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/entities/item.dart';

abstract class ShareDataAccess {
  Future<List<Item>?> getItems();

  Stream<List<Item>> newItemsStream();

  Future<bool> writeTextItem(String text);

  Future<bool> writeImageItem(FileInfo fileInfo);

  Future<bool> writeFileItem(FileInfo fileInfo);

  Future<bool> deleteItem(Item item);

  Future<bool> download(Item item);
}
