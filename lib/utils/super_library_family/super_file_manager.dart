import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:passaround/utils/logger.dart';
import 'package:super_clipboard/super_clipboard.dart';

import '../../data_structures/file_info.dart';

@immutable
class SuperFileManager {
  final DataReader _reader;

  DataReader get reader => _reader;

  const SuperFileManager(this._reader);

  bool containsPlainText() => _reader.canProvide(Formats.plainText);

  void readText(void Function(String value) onSuccess, {void Function(Object error)? onError}) {
    _reader.getValue<String>(
      Formats.plainText,
      (value) => onSuccess(value ?? ""),
      onError: (error) {
        Logger.ePrint(error);
        if (onError != null) {
          onError(error);
        }
      },
    );
  }

  void readGenericFile(void Function(FileInfo fileInfo) onSuccess, {void Function(Object error)? onError}) {
    final List<DataFormat<Object>> formats =
        Formats.standardFormats.where((format) => format is FileFormat && _reader.canProvide(format)).toList();

    _readFile(fileFormat: formats[0] as FileFormat, onSuccess: onSuccess, onError: onError);
  }

  void readImage({
    String? customFileName,
    required void Function(FileInfo fileInfo) onSuccess,
    void Function(Object error)? onError,
  }) {
    _readFile(
      customFileName: customFileName,
      fileFormat: Formats.png,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  void _readFile({
    String? customFileName,
    required FileFormat fileFormat,
    required void Function(FileInfo fileInfo) onSuccess,
    void Function(Object error)? onError,
  }) {
    _reader.getFile(
      fileFormat,
      (file) async {
        final Uint8List bytes = await file.readAll();
        final FileInfo fileInfo = FileInfo(
          name: customFileName ?? (file.fileName ?? ""),
          bytes: bytes,
        );
        onSuccess(fileInfo);
      },
      onError: (error) {
        Logger.ePrint(error);
        if (onError != null) {
          onError(error);
        }
      },
    );
  }
}
