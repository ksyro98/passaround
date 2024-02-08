import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaround/entities/file_item.dart';
import 'package:passaround/entities/image_item.dart';
import 'package:passaround/entities/text_item.dart';
import 'package:passaround/features/share/bloc/share_bloc.dart';
import 'package:passaround/features/share/ui/list/item_cards/file_item_card.dart';
import 'package:passaround/features/share/ui/list/item_cards/image_item_card.dart';
import 'package:passaround/utils/constants.dart';
import 'package:passaround/utils/native/native_api_provider.dart';
import 'package:passaround/widgets/clickable_texts/get_it_on_mobile_text.dart';
import 'package:passaround/widgets/simple_snack_bar.dart';
import 'package:passaround/features/share/ui/list/item_cards/text_item_card.dart';
import 'package:passaround/widgets/loading_indicator.dart';

import '../../../../entities/item.dart';
import '../../../../utils/native/native_version.dart';
import '../../../../widgets/clickable_texts/open_on_the_web_text.dart';
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
      return _getEmptyScreen();
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

  Widget _getEmptyScreen() {
    return Center(
      child: SizedBox(
        width: 320,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: SvgPicture.asset(
                  AssetValues.logoButterfliesFlying,
                  width: 150,
                  height: 150,
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Seems like you haven't\nsent anything yet.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              kIsWeb ? const GetItOnMobileText() : const OpenOnTheWebText(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteItem(Item item) => context.read<ShareBloc>().add(ShareDeleted(item));

  void _showCopyMessage(String message) async {
    if (await _shouldDisplayToast()) {
      // Do not use BuildContexts across async gaps: https://dart.dev/tools/linter-rules/use_build_context_synchronously
      if (!mounted) return;

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
