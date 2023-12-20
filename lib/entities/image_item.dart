import '../utils/file_utils.dart';
import 'item.dart';

class ImageItem extends Item {
  final String imageUrl;
  final String imagePath;

  String get name => FileUtils.getNameWithExtension(imagePath);

  @override
  ItemType get type => ItemType.image;

  ImageItem.fromMap(Map<String, dynamic> map)
      : imageUrl = map['downloadUrl'],
        imagePath = map["imagePath"],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ts': ts,
      'downloadUrl': imageUrl,
      'imagePath': imagePath,
    };
  }

  @override
  List<Object?> get props => [id, ts, imageUrl, imagePath];
}
