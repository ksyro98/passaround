
import 'package:passaround/data_structures/either.dart';
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/entities/item.dart';

abstract class ShareDataAccess {
  Future<List<Item>?> getItems();

  Stream<List<Item>> newItemsStream();

  Future<bool> writeTextItem(String text);

  Stream<Either<String, double>> writeImageItem(FileInfo fileInfo);

  Stream<Either<String, double>> writeFileItem(FileInfo fileInfo);

  Future<bool> writeFileInfo(FileInfo fileInfo);

  Future<bool> deleteItem(Item item);

  Future<bool> download(Item item);
}
