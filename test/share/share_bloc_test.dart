import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/features/share/bloc/share_bloc.dart';
import 'package:passaround/features/share/bloc/share_data_access.dart';

import 'dummy_items.dart';
import 'mock_share_data_access.dart';

void main() {
  late ShareDataAccess dataAccess;

  group("happy paths :)", () {
    setUp(() => dataAccess = MockShareDataAccess(shouldSucceed: true));

    blocTest(
      "items are loaded",
      build: () => ShareBloc(dataAccess),
      act: (bloc) => bloc.add(const ShareLoadingStarted()),
      expect: () => [
        const ShareState(ShareStateValue.loading, [], ""),
        ShareState(ShareStateValue.idle, DummyItems.someText, ""),
      ],
    );

    blocTest(
      "text item is sent",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.idle, [], ""),
      act: (bloc) => bloc.add(ShareTextSent(DummyItems.dummyTextItem1.text)),
      expect: () => [
        const ShareState(ShareStateValue.sending, [], ""),
        const ShareState(ShareStateValue.idle, [], ""),
      ],
    );

    blocTest(
      "image item is sent",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.idle, [], ""),
      act: (bloc) => bloc.add(ShareImageSent(FileInfo(
        name: DummyItems.dummyImageItem1.name,
        tsLoaded: DateTime.now().millisecondsSinceEpoch,
      ))),
      expect: () => [
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 0),
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 0.25),
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 0.5),
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 0.75),
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 1),
        const ShareState(ShareStateValue.sending, [], ""),
        const ShareState(ShareStateValue.idle, [], ""),
      ],
    );

    blocTest(
      "file item is sent",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.idle, [], ""),
      act: (bloc) => bloc.add(ShareFileSent(FileInfo(
        name: DummyItems.dummyFileItem1.name,
        tsLoaded: DateTime.now().millisecondsSinceEpoch,
      ))),
      expect: () => [
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 0),
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 0.25),
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 0.5),
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 0.75),
        const ShareState(ShareStateValue.sendingFile, [], "", sendingProgress: 1),
        const ShareState(ShareStateValue.sending, [], ""),
        const ShareState(ShareStateValue.idle, [], ""),
      ],
    );

    blocTest("item is downloaded",
        build: () => ShareBloc(dataAccess),
        seed: () => const ShareState(ShareStateValue.idle, [], ""),
        act: (bloc) => bloc.add(ShareDownloadRequested(DummyItems.dummyImageItem1)),
        expect: () => [
              const ShareState(ShareStateValue.downloading, [], ""),
              const ShareState(ShareStateValue.idle, [], ""),
            ]);

    blocTest(
      "item is deleted",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.idle, [], ""),
      act: (bloc) => bloc.add(ShareDeleted(DummyItems.dummyTextItem1)),
      expect: () => [
        const ShareState(ShareStateValue.deleting, [], ""),
        const ShareState(ShareStateValue.idle, [], ""),
      ],
    );

    blocTest(
      "items are received",
      build: () => ShareBloc(dataAccess),
      act: (bloc) async {
        bloc.add(const ShareLoadingStarted());
        await Future.delayed(
          const Duration(milliseconds: 500),
          () => (dataAccess as MockShareDataAccess).addDummyItemsToStream(),
        );
      },
      expect: () => [
        const ShareState(ShareStateValue.loading, [], ""),
        ShareState(ShareStateValue.idle, DummyItems.someText, ""),
        ShareState(ShareStateValue.idle, DummyItems.allText, ""),
      ],
    );
  });

  group("with errors", () {
    setUp(() => dataAccess = MockShareDataAccess(shouldSucceed: false));

    blocTest(
      "fails to load items",
      build: () => ShareBloc(dataAccess),
      act: (bloc) => bloc.add(const ShareLoadingStarted()),
      expect: () => [
        const ShareState(ShareStateValue.loading, [], ""),
        const ShareState(ShareStateValue.error, [], ShareBloc.retrieveError),
      ],
    );

    blocTest(
      "text item isn't sent",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.idle, [], ""),
      act: (bloc) => bloc.add(ShareTextSent(DummyItems.dummyTextItem1.text)),
      expect: () => [
        const ShareState(ShareStateValue.sending, [], ""),
        const ShareState(ShareStateValue.error, [], ShareBloc.sendingError),
      ],
    );

    blocTest(
      "image item isn't sent",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.idle, [], ""),
      act: (bloc) => bloc.add(ShareImageSent(FileInfo(
        name: DummyItems.dummyImageItem1.name,
        tsLoaded: DateTime.now().millisecondsSinceEpoch,
      ))),
      expect: () => [
        const ShareState(ShareStateValue.sendingFile, [], ""),
        const ShareState(ShareStateValue.error, [], ShareBloc.sendingError),
      ],
    );

    blocTest(
      "file item isn't sent",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.idle, [], ""),
      act: (bloc) => bloc.add(ShareFileSent(FileInfo(
        name: DummyItems.dummyFileItem1.name,
        tsLoaded: DateTime.now().millisecondsSinceEpoch,
      ))),
      expect: () => [
        const ShareState(ShareStateValue.sendingFile, [], ""),
        const ShareState(ShareStateValue.error, [], ShareBloc.sendingError),
      ],
    );

    blocTest("item isn't downloaded",
        build: () => ShareBloc(dataAccess),
        seed: () => const ShareState(ShareStateValue.idle, [], ""),
        act: (bloc) => bloc.add(ShareDownloadRequested(DummyItems.dummyImageItem1)),
        expect: () => [
              const ShareState(ShareStateValue.downloading, [], ""),
              const ShareState(ShareStateValue.error, [], ShareBloc.downloadingError),
            ]);

    blocTest(
      "item isn't deleted",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.idle, [], ""),
      act: (bloc) => bloc.add(ShareDeleted(DummyItems.dummyTextItem1)),
      expect: () => [
        const ShareState(ShareStateValue.deleting, [], ""),
        const ShareState(ShareStateValue.error, [], ShareBloc.deletingError),
      ],
    );

    blocTest(
      "recovers from error",
      build: () => ShareBloc(dataAccess),
      seed: () => const ShareState(ShareStateValue.error, [], "some error"),
      act: (bloc) => bloc.add(const ShareRecoverFromError()),
      expect: () => [const ShareState(ShareStateValue.idle, [], "")],
    );
  });

  tearDownAll(() => (dataAccess as MockShareDataAccess).close());
}
