import 'package:equatable/equatable.dart';

enum ItemType {
  text, image, file
}

abstract class Item extends Equatable {
  final String id;
  final int ts;

  ItemType get type;

  Item.fromMap(Map<String, dynamic> map) : id = map['id'] ?? '', ts = map['ts'] ?? 0;

  Map<String, dynamic> toMap();
}