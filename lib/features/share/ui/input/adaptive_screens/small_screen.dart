import 'package:flutter/material.dart';

class SmallScreenShareInputField extends StatefulWidget {
  final TextEditingController itemTextController;
  final bool sending;
  final double sendingProgress;
  final void Function() sendTextItem;
  final Future<void> Function() sendFile;

  const SmallScreenShareInputField({
    super.key,
    required this.itemTextController,
    required this.sending,
    required this.sendingProgress,
    required this.sendTextItem,
    required this.sendFile,
  });

  @override
  State<SmallScreenShareInputField> createState() => _SmallScreenShareInputFieldState();
}

class _SmallScreenShareInputFieldState extends State<SmallScreenShareInputField> {
  bool _fileSelectionLoading = false;
  bool _isTextInput = false;

  void _updateInputType(isText) {
    setState(() => _isTextInput = isText);
  }

  void _updateFileSelectionLoading(fileSelectionLoading) {
    setState(() => _fileSelectionLoading = fileSelectionLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 8, 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.itemTextController,
              minLines: 1,
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              onChanged: (value) => _updateInputType(value != ""),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Something awesome",
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: (_fileSelectionLoading || widget.sending) ? null : _onIconPressed,
            icon: (_fileSelectionLoading || widget.sending)
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: widget.sendingProgress != 0 ? widget.sendingProgress : null,
                    ),
                  )
                : _getIconFromInputType(),
          ),
        ],
      ),
    );
  }

  Future<void> _onIconPressed() async => _isTextInput ? _onSendTextPressed() : await _onFileSelectionPressed();

  Icon _getIconFromInputType() => _isTextInput ? const Icon(Icons.check) : const Icon(Icons.add, size: 30);

  void _onSendTextPressed() {
    widget.sendTextItem();
    _updateInputType(false);
  }

  Future<void> _onFileSelectionPressed() async {
    _updateFileSelectionLoading(true);
    await widget.sendFile();
    _updateFileSelectionLoading(false);
  }
}
