import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/entities/image_item.dart';

import '../../bloc/share_bloc.dart';

class ImageScreen extends StatefulWidget {
  final ImageItem item;

  const ImageScreen({super.key, required this.item});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  TapDownDetails _doubleTapDetails = TapDownDetails();
  final TransformationController _transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _goBack,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: _download,
            icon: const Icon(Icons.download),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: GestureDetector(
        onDoubleTapDown: (d) => _doubleTapDetails = d,
        onDoubleTap: _handleDoubleTap,
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Image.network(
                widget.item.imageUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goBack() {
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
  }

  void _download() {
    context.read<ShareBloc>().add(ShareDownloadRequested(widget.item));
  }

  // from https://stackoverflow.com/questions/65408346/flutter-enable-image-zoom-in-out-on-double-tap-using-interactiveviewer
  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
    }
  }
}

