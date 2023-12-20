import 'package:passaround/utils/file_utils.dart';

import 'item.dart';

class FileItem extends Item {
  final String filePath;

  String get name => FileUtils.getNameWithExtension(filePath);

  @override
  ItemType get type => ItemType.file;

  FileItem.fromMap(Map<String, dynamic> map) : filePath = map['filePath'], super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ts': ts,
      'filePath': filePath
    };
  }

  @override
  List<Object?> get props => [id, ts, filePath];

}