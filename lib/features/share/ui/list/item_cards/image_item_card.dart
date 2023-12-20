import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/features/share/ui/list/item_cards/item_card_base.dart';
import 'package:passaround/navigation/image_go_route.dart';
import 'package:passaround/utils/logger.dart';

import '../../../../../entities/image_item.dart';
import '../../../../../entities/item.dart';

class ImageItemCard extends StatefulWidget {
  final ImageItem item;
  final void Function(Item item) onDownloadPressed;
  final void Function(Item item) onDeletePressed;

  const ImageItemCard({
    super.key,
    required this.item,
    required this.onDownloadPressed,
    required this.onDeletePressed,
  });

  @override
  State<ImageItemCard> createState() => _ImageItemCardState();
}

class _ImageItemCardState extends State<ImageItemCard> {
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return ItemCardBase(
      child: Row(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.item.imageUrl,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    _progress = loadingProgress != null
                        ? (loadingProgress.cumulativeBytesLoaded) /
                            (loadingProgress.expectedTotalBytes ?? loadingProgress.cumulativeBytesLoaded)
                        : null;
                    return _progress != null
                        ? _getImageLoader()
                        : GestureDetector(
                            onTap: _navigateToImageScreen,
                            child: child,
                          );
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    Logger.ePrint(stackTrace);
                    return const Center(
                      child: Row(
                        children: [
                          Text("An error occurred while loading your image."),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Column(
            children: [
              IconButton(
                onPressed: _progress == null ? () => widget.onDownloadPressed(widget.item) : null,
                icon: const Icon(Icons.download, size: 25),
              ),
              IconButton(
                onPressed: _progress == null ? () => widget.onDeletePressed(widget.item) : null,
                icon: Icon(Icons.delete_outline, size: 25, color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getImageLoader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              value: _progress ?? 0,
              strokeWidth: 3,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToImageScreen() {
    if (!kIsWeb) {
      GoRouter.of(context).pushNamed(
        ImageGoRoute.name,
        extra: widget.item,
      );
    }
  }
}
