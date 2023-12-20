import 'item.dart';

class TextItem extends Item {
  final String text;

  @override
  ItemType get type => ItemType.text;

  TextItem.fromMap(Map<String, dynamic> map) : text = map['text'], super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ts': ts,
      'text': text
    };
  }

  @override
  List<Object?> get props => [id, ts, text];
}