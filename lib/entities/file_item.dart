import 'package:passaround/utils/file_utils.dart';

import 'item.dart';

class FileItem extends Item {
  final String fileUrl;
  final String filePath;
  final int size;

  String get name => FileUtils.getNameWithExtension(filePath);
  String get nameWithoutExtension => FileUtils.getNameWithoutExtension(filePath);
  String get extension => FileUtils.getExtension(filePath);

  @override
  ItemType get type => ItemType.file;

  FileItem.fromMap(Map<String, dynamic> map)
      : fileUrl = map['downloadUrl'],
        filePath = map['path'],
        size = map['size'],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ts': ts,
      'downloadUrl': fileUrl,
      'path': filePath,
      'size': size,
    };
  }

  @override
  List<Object?> get props => [id, ts, fileUrl, filePath];
}
