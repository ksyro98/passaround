import 'dart:async';

import 'package:passaround/data_structures/either.dart';
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
  Stream<Either<String, double>> writeImageItem(FileInfo fileInfo) {
    return shouldSucceed
        ? Stream.fromIterable([
      const Either.secondOnly(0),
      const Either.secondOnly(0.25),
      const Either.secondOnly(0.5),
      const Either.secondOnly(0.75),
      const Either.secondOnly(1),
    ])
        : Stream.fromIterable([const Either.firstOnly("error")]);
  }

  @override
  Stream<Either<String, double>> writeFileItem(FileInfo fileInfo) {
    return shouldSucceed
        ? Stream.fromIterable([
            const Either.secondOnly(0),
            const Either.secondOnly(0.25),
            const Either.secondOnly(0.5),
            const Either.secondOnly(0.75),
            const Either.secondOnly(1),
          ])
        : Stream.fromIterable([const Either.firstOnly("error")]);
  }

  @override
  Future<bool> writeFileInfo(FileInfo fileInfo) async {
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

  void close() {
    _streamController.close();
  }
}
