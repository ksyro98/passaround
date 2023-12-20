import 'package:passaround/entities/file_item.dart';
import 'package:passaround/entities/image_item.dart';
import 'package:passaround/entities/item.dart';
import 'package:passaround/entities/text_item.dart';

class DummyItems {
  static final TextItem dummyTextItem1 = TextItem.fromMap(const {
    "id": "dummyId1",
    "ts": 1,
    "text": "dummy text 1",
  });

  static final TextItem dummyTextItem2 = TextItem.fromMap(const {
    "id": "dummyId2",
    "ts": 2,
    "text": "dummy text 2",
  });

  static final TextItem dummyTextItem3 = TextItem.fromMap(const {
    "id": "dummyId3",
    "ts": 3,
    "text": "dummy text 3",
  });

  static final List<Item> someText = [dummyTextItem1, dummyTextItem2];
  static final List<Item> allText = [dummyTextItem1, dummyTextItem2, dummyTextItem3];


  static final ImageItem dummyImageItem1 = ImageItem.fromMap(const {
    "id": "dummyId1",
    "ts": 1,
    "path": "dummyPath",
    "downloadUrl": "dummyUrl",
  });


  static final FileItem dummyFileItem1 = FileItem.fromMap(const {
    "id": "dummyId1",
    "ts": 1,
    "path": "./something.pdf",
    "downloadUrl": "dummyUrl",
    "size": 0,
  });
}
