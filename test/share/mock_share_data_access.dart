import 'dart:async';

import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/entities/item.dart';
import 'package:passaround/features/share/bloc/share_data_access.dart';

import 'dummy_items.dart';

class MockShareDataAccess implements ShareDataAccess {
  final StreamController<List<Item>> _streamController = StreamController.broadcast();
  final bool shouldSucceed;

  MockShareDataAccess({required this.shouldSucceed});

  @override
  Future<List<Item>?> getItems() async {
    return shouldSucceed ? DummyItems.someText : null;
  }

  void addDummyItemsToStream() {
    _streamController.sink.add(DummyItems.allText);
  }

  @override
  Stream<List<Item>> newItemsStream() {
    return _streamController.stream;
  }

  @override
  Future<bool> writeTextItem(String text) async {
    return shouldSucceed;
  }

  @override
  Future<bool> writeImageItem(FileInfo fileInfo) async {
    return shouldSucceed;
  }

  @override
  Future<bool> writeFileItem(FileInfo fileInfo) async {
    return shouldSucceed;
  }

  @override
  Future<bool> deleteItem(Item item) async {
    return shouldSucceed;
  }

  @override
  Future<bool> download(Item item) async {
    return shouldSucceed;
  }

  void close(){
    _streamController.close();
  }
}

