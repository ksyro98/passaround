import 'package:flutter/material.dart';
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/features/share/ui/input/adaptive_screens/widgets/paste_button.dart';

import '../../../../../utils/super_library_family/drag_drop/input_drop_region.dart';

class LargeScreenShareInputField extends StatefulWidget {
  final TextEditingController itemTextController;
  final bool sending;
  final void Function({String? text}) sendTextItem;
  final Future<void> Function() selectAndSendFile;
  final void Function(FileInfo) sendAddedFile;
  final void Function() onError;

  const LargeScreenShareInputField({
    super.key,
    required this.itemTextController,
    required this.sending,
    required this.sendTextItem,
    required this.selectAndSendFile,
    required this.sendAddedFile,
    required this.onError,
  });

  @override
  State<LargeScreenShareInputField> createState() => _LargeScreenShareInputFieldState();
}

class _LargeScreenShareInputFieldState extends State<LargeScreenShareInputField> {
  bool _fileSelectionLoading = false;

  bool get _isDisabled => _fileSelectionLoading || widget.sending;

  @override
  Widget build(BuildContext context) {
    return InputDropRegion(
      onTextDropped: (text) => widget.sendTextItem(text: text),
      onImageOrFileDropped: widget.sendAddedFile,
      onError: widget.onError,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 36, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Let's pass around something awesome!", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            const Text('Just type it below and click "Send"', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            TextField(
              controller: widget.itemTextController,
              maxLines: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: _isDisabled ? null : widget.sendTextItem,
                  child: const Text("Send"),
                )
              ],
            ),
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text("or...", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    widget.sending
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          )
                        : FilledButton(
                            onPressed: _isDisabled ? null : _onFileSelectionPressed,
                            child: const Text("Upload Image or File"),
                          ),
                    const SizedBox(height: 4),
                    const Text("You can also drag and drop it here :)", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("or even... paste an image", style: TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                PasteButton(
                  isDisabled: _isDisabled,
                  onTextPasted: (text) => setState(() => widget.itemTextController.text += text),
                  onImagePasted: widget.sendAddedFile,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onFileSelectionPressed() async {
    setState(() => _fileSelectionLoading = true);
    await widget.selectAndSendFile();
    setState(() => _fileSelectionLoading = false);
  }
}
