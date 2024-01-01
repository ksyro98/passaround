import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passaround/entities/file_item.dart';
import 'package:passaround/entities/image_item.dart';
import 'package:passaround/entities/text_item.dart';
import 'package:passaround/features/share/bloc/share_bloc.dart';
import 'package:passaround/features/share/ui/list/item_cards/file_item_card.dart';
import 'package:passaround/features/share/ui/list/item_cards/image_item_card.dart';
import 'package:passaround/utils/constants.dart';
import 'package:passaround/utils/native/native_api_provider.dart';
import 'package:passaround/widgets/simple_snack_bar.dart';
import 'package:passaround/features/share/ui/list/item_cards/text_item_card.dart';
import 'package:passaround/widgets/loading_indicator.dart';

import '../../../../entities/item.dart';
import '../../../../utils/native/native_version.dart';
import '../../../../widgets/empty.dart';

class ShareItemsList extends StatefulWidget {
  final ShareState state;

  const ShareItemsList({super.key, required this.state});

  @override
  State<ShareItemsList> createState() => _ShareItemsListState();
}

class _ShareItemsListState extends State<ShareItemsList> {
  @override
  Widget build(BuildContext context) {
    return widget.state.value == ShareStateValue.loading ? const LoadingIndicator() : _getList(widget.state.data);
  }

  Widget _getList(List<Item> items) {
    if (items.isEmpty) {
      return const Center(child: Text("Seems like you haven't sent anything yet."));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final Item item = items[index];
        if (item is TextItem) {
          return TextItemCard(
            item: item,
            onDeletePressed: _deleteItem,
            showSnackBarMessage: _showCopyMessage,
          );
        } else if (item is ImageItem) {
          return ImageItemCard(
            item: item,
            onDownloadPressed: _download,
            onDeletePressed: _deleteItem,
          );
        } else if (item is FileItem) {
          return FileItemCard(
            item: item,
            onItemPressed: _download,
            onDownloadPressed: _download,
            onDeletePressed: _deleteItem,
          );
        } else {
          return const Empty();
        }
      },
    );
  }

  void _deleteItem(Item item) => context.read<ShareBloc>().add(ShareDeleted(item));

  void _showCopyMessage(String message) async {
    if (await _shouldDisplayToast()) {
      if (!mounted) return; // Do not use BuildContexts across async gaps: https://dart.dev/tools/linter-rules/use_build_context_synchronously

      SimpleSnackBar.show(
        context,
        message,
        duration: const Duration(milliseconds: 2000),
      );
    }
  }

  Future<bool> _shouldDisplayToast() async {
    if (kIsWeb) {
      return true;
    } else if (Platform.isAndroid) {
      final NativeVersion nativeVersion = await NativeApiProvider.instance.getVersion();
      if (int.parse(nativeVersion.version) > NativeValues.androidApi12LVersionCode) {
        return false;
      }
    }
    return true;
  }

  void _download(Item item) => context.read<ShareBloc>().add(ShareDownloadRequested(item));
}
