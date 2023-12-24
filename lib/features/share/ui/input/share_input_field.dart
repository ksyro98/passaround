import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/features/share/bloc/share_bloc.dart';
import 'package:passaround/features/share/ui/input/adaptive_screens/small_screen.dart';

import 'adaptive_screens/large_screen.dart';

class ShareInputField extends StatefulWidget {
  final ShareState state;
  final bool isSmallScreen;

  const ShareInputField({super.key, required this.state, required this.isSmallScreen});

  @override
  State<ShareInputField> createState() => _ShareInputFieldState();
}

class _ShareInputFieldState extends State<ShareInputField> {
  final TextEditingController _itemTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return widget.isSmallScreen
        ? SmallScreenShareInputField(
            itemTextController: _itemTextController,
            sending: widget.state.value == ShareStateValue.sending,
            sendTextItem: _sendTextItem,
            sendFile: _selectAndSendFile,
          )
        : LargeScreenShareInputField(
            itemTextController: _itemTextController,
            sending: widget.state.value == ShareStateValue.sending,
            sendTextItem: _sendTextItem,
            selectAndSendFile: _selectAndSendFile,
            sendAddedFile: _sendAddedFile,
            onError: _onError,
          );
  }

  void _sendTextItem({String? text}) {
    final String textToSend = text ?? _itemTextController.text;
    if (textToSend.isNotEmpty) {
      context.read<ShareBloc>().add(ShareTextSent(textToSend));
      _itemTextController.text = "";
    }
  }

  Future<void> _selectAndSendFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final FileInfo fileInfo = FileInfo(
        name: result.files.single.name,
        path: kIsWeb ? null : result.files.single.path,
        bytes: result.files.single.bytes,
      );

      if (fileInfo.path != null || fileInfo.bytes != null) {
        _manageSelectedFile(fileInfo);
      }
    }
  }

  void _sendAddedFile(FileInfo fileInfo) async {
    if (fileInfo.name != "") {
      _manageSelectedFile(fileInfo);
    }
  }

  void _manageSelectedFile(FileInfo fileInfo) => fileInfo.isImage ? _sendImageItem(fileInfo) : _sendFileItem(fileInfo);

  void _sendImageItem(FileInfo fileInfo) => context.read<ShareBloc>().add(ShareImageSent(fileInfo));

  void _sendFileItem(FileInfo fileInfo) => context.read<ShareBloc>().add(ShareFileSent(fileInfo));

  void _onError() => context.read<ShareBloc>().add(const ShareFailed(ShareBloc.unknownError));
}
