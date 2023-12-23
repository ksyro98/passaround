import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passaround/entities/text_item.dart';
import 'package:passaround/utils/links_in_text/linkable_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../entities/item.dart';
import 'item_card_base.dart';

class TextItemCard extends StatelessWidget {
  final TextItem item;
  final void Function(Item) onDeletePressed;
  final void Function(String) showSnackBarMessage;

  const TextItemCard({
    super.key,
    required this.item,
    required this.onDeletePressed,
    required this.showSnackBarMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ItemCardBase(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: LinkableText(
              item.text,
              onLinkPressed: _onLinkTap,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
              linkTextStyle: const TextStyle(decoration: TextDecoration.underline),
            ),
            // child: SelectableText(
            //   item.text,
            //   style: const TextStyle(overflow: TextOverflow.ellipsis),
            // ),
          ),
          Row(
            children: [
              IconButton(onPressed: _copyTextToClipboard, icon: const Icon(Icons.copy, size: 22)),
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
        ],
      ),
    );
  }

  Future<void> _onLinkTap(String href) async {
    final Uri uri = Uri.parse(href);
    if(await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  Future<void> _copyTextToClipboard() async {
    await Clipboard.setData(ClipboardData(text: item.text));
    showSnackBarMessage("Content copied to clipboard!");
  }
}
