import 'package:flutter/material.dart';
import 'package:passaround/features/share/ui/list/item_cards/item_card_base.dart';
import 'package:passaround/utils/file_utils.dart';

import '../../../../../entities/file_item.dart';
import '../../../../../entities/item.dart';

class FileItemCard extends StatelessWidget {
  final FileItem item;
  final void Function(Item item) onItemPressed;
  final void Function(Item item) onDownloadPressed;
  final void Function(Item item) onDeletePressed;

  const FileItemCard({
    super.key,
    required this.item,
    required this.onItemPressed,
    required this.onDownloadPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ItemCardBase(
      child: Row(
        children: [
          Icon(
            Icons.description,
            size: 25,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onItemPressed(item),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        FileUtils.transformSizeUnit(item.size),
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => onDownloadPressed(item),
            icon: const Icon(Icons.download, size: 25),
          ),
          IconButton(
            onPressed: () => onDeletePressed(item),
            icon: Icon(
              Icons.delete_outline,
              size: 25,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  // String get _text => "${item.nameWithoutExtension} (${item.extension})";
}
