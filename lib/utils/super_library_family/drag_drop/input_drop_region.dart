import 'package:flutter/material.dart';
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/utils/super_library_family/super_file_manager.dart';
import 'package:super_clipboard/src/reader.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import 'drop_hover_visual.dart';

class InputDropRegion extends StatefulWidget {
  final Widget child;
  final void Function(String) onTextDropped;
  final void Function(FileInfo) onImageOrFileDropped;
  final void Function() onError;

  const InputDropRegion({
    super.key,
    required this.child,
    required this.onTextDropped,
    required this.onImageOrFileDropped,
    required this.onError,
  });

  @override
  State<InputDropRegion> createState() => _InputDropRegionState();
}

class _InputDropRegionState extends State<InputDropRegion> {
  bool _itemHasEntered = false;

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: Formats.standardFormats,
      onDropOver: (_) => DropOperation.copy,
      onDropEnter: (event) {
        setState(() => _itemHasEntered = true);
      },
      onDropLeave: (event) {
        setState(() => _itemHasEntered = false);
      },
      onPerformDrop: (PerformDropEvent event) async {
        final item = event.session.items.first;
        final DataReader? reader = item.dataReader;

        if(reader != null) {
          final SuperFileManager fileManager = SuperFileManager(reader);
          fileManager.containsPlainText() ? _manageDroppedText(fileManager) : _manageDroppedFile(fileManager);
        }
      },
      child: Stack(
        children: [
          widget.child,
          DropHoverVisual(show: _itemHasEntered),
        ],
      ),
    );
  }

  void _manageDroppedText(SuperFileManager fileManager) {
    fileManager.readText((value) => widget.onTextDropped(value), onError: (_) => widget.onError());
  }

  void _manageDroppedFile(SuperFileManager fileManager) {
    fileManager.readGenericFile((fileInfo) =>  widget.onImageOrFileDropped(fileInfo));
  }
}
