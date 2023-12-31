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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 8, 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.itemTextController,
              maxLines: 1,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: widget.sending ? null : widget.sendTextItem,
                    icon: const Icon(Icons.check),
                  ),
                  hintText: "Something awesome"),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: (_fileSelectionLoading || widget.sending) ? null : _onFileSelectionPressed,
            icon: (_fileSelectionLoading || widget.sending)
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, value: widget.sendingProgress),
                  )
                : const Icon(Icons.add, size: 30),
          ),
        ],
      ),
    );
  }

  Future<void> _onFileSelectionPressed() async {
    setState(() => _fileSelectionLoading = true);
    await widget.sendFile();
    setState(() => _fileSelectionLoading = false);
  }
}
