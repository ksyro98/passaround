import 'package:flutter/material.dart';
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/utils/super_library_family/copy_paste/pasteable.dart';

class PasteButton extends StatelessWidget with Pasteable {
  final bool isDisabled;
  final void Function(String) onTextPasted;
  final void Function(FileInfo) onImagePasted;

  const PasteButton({
    super.key,
    required this.isDisabled,
    required this.onTextPasted,
    required this.onImagePasted,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isDisabled ? null : () => paste(onTextPasted: onTextPasted, onImagePasted: onImagePasted),
      icon: Icon(Icons.paste, color: Theme.of(context).colorScheme.primary),
    );
  }
}
