import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:passaround/utils/logger.dart';
import 'package:super_clipboard/src/reader.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import 'drop_hover_visual.dart';

class InputDropRegion extends StatefulWidget {
  final Widget child;
  final void Function(String) sendTextItem;
  final void Function(Uint8List, String) sendImageOrFile;
  final void Function() onError;

  const InputDropRegion({
    super.key,
    required this.child,
    required this.sendTextItem,
    required this.sendImageOrFile,
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
        final reader = item.dataReader!;

        reader.canProvide(Formats.plainText) ? _manageDroppedText(reader) : _manageDroppedFile(reader);
      },
      child: Stack(
        children: [
          widget.child,
          DropHoverVisual(show: _itemHasEntered),
        ],
      ),
    );
  }

  void _manageDroppedText(DataReader reader) {
    reader.getValue<String>(
      Formats.plainText,
      (value) {
        if (value != null) {
          widget.sendTextItem(value);
        }
      },
      onError: (error) {
        Logger.ePrint(error);
        widget.onError();
      },
    );
  }

  void _manageDroppedFile(DataReader reader) {
    final List<DataFormat<Object>> formats =
        Formats.standardFormats.where((format) => format is FileFormat && reader.canProvide(format)).toList();

    reader.getFile(formats[0] as FileFormat, (file) async {
      final Uint8List bytes = await file.readAll();
      widget.sendImageOrFile(bytes, file.fileName ?? "");
    });
  }
}
