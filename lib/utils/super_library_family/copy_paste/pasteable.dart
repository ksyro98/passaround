import 'dart:async';

import 'package:passaround/utils/super_library_family/super_file_manager.dart';
import 'package:super_clipboard/super_clipboard.dart';

import '../../../../../../data_structures/file_info.dart';


mixin Pasteable {
  FutureOr<void> paste({
    required void Function(String) onTextPasted,
    required void Function(FileInfo) onImagePasted,
  }) async {
    final ClipboardReader? reader = await _getReader();
    if(reader != null) {
      final SuperFileManager fileManager = SuperFileManager(reader);
      fileManager.containsPlainText()
          ? _addPastedText(fileManager, onTextPasted)
          : _sendPastedFile(fileManager, onImagePasted);
    }
  }

  Future<ClipboardReader?> _getReader() async {
    final clipboard = SystemClipboard.instance;
    if (clipboard != null) {
      final reader = await clipboard.read();
      return reader;
    }
    return null;
  }

  void _addPastedText(SuperFileManager fileManager, void Function(String) onTextPasted) {
    fileManager.readText((value) => onTextPasted(value));
  }

  Future<void> _sendPastedFile(SuperFileManager fileManager, Function(FileInfo) onImagePasted) async {
    fileManager.readImage(
      customFileName: "${DateTime.now().millisecondsSinceEpoch}.png",
      onSuccess: onImagePasted,
    );
  }
}
