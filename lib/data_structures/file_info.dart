import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:passaround/utils/file_utils.dart';

@immutable
class FileInfo {
  final String name;
  final String? path;
  final Uint8List? bytes;

  bool get isImage => FileUtils.isImage(name);

  const FileInfo({required this.name, this.path, this.bytes});

  @override
  String toString() => "FileInfo(name: $name, path: $path, bytes: $bytes)";
}