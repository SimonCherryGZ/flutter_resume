import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:photo_view/photo_view.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({
    super.key,
    required this.assetEntity,
  });

  final AssetEntity assetEntity;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late final PhotoViewControllerBase<PhotoViewControllerValue>
      _photoViewController;

  @override
  void initState() {
    super.initState();
    _photoViewController = PhotoViewController();
  }

  @override
  void dispose() {
    _photoViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canvasKey = GlobalKey();
    final dp = MediaQuery.devicePixelRatioOf(context);
    return BlocProvider(
      create: (context) => EditorBloc(canvasKey: canvasKey),
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<EditorBloc, EditorState>(
                listenWhen: (p, c) => p.isShowLoading != c.isShowLoading,
                listener: (context, state) {
                  final isShowLoading = state.isShowLoading;
                  if (isShowLoading) {
                    EasyLoading.show();
                  } else {
                    EasyLoading.dismiss();
                  }
                },
              ),
            ],
            child: Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                title: const Text('编辑'),
                actions: [
                  IconButton(
                    onPressed: () {
                      // 画布宽高
                      final renderObject =
                          canvasKey.currentContext?.findRenderObject();
                      final renderBox = renderObject != null
                          ? (renderObject as RenderBox)
                          : null;
                      final canvasSize =
                          renderBox?.size ?? const Size.square(1);
                      debugPrint('canvasSize: $canvasSize');
                      // 图片宽高
                      final photoSize = widget.assetEntity.size;
                      debugPrint('photoSize: $photoSize');
                      // PhotoView 缩放
                      final scale = _photoViewController.scale ?? 1.0;
                      debugPrint('scale: $scale');
                      // 裁掉空白区域
                      final scaleX = canvasSize.width / photoSize.width;
                      final scaleY = canvasSize.height / photoSize.height;
                      final fitCenterScale = min(scaleX, scaleY);
                      final centerCropScale = max(scaleX, scaleY);
                      debugPrint('fitCenterScale: $fitCenterScale');
                      debugPrint('centerCropScale: $centerCropScale');
                      Rect? cropRect;
                      if (scale < centerCropScale) {
                        final scaleSize = photoSize * scale;
                        cropRect = Rect.fromLTWH(
                          (canvasSize.width - scaleSize.width) / 2 * dp,
                          (canvasSize.height - scaleSize.height) / 2 * dp,
                          scaleSize.width * dp,
                          scaleSize.height * dp,
                        );
                      }
                      context
                          .read<EditorBloc>()
                          .add(ExportImage(cropRect: cropRect));
                    },
                    icon: const Icon(Icons.save),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: RepaintBoundary(
                      key: canvasKey,
                      child: Stack(
                        children: [
                          Center(
                            child: PhotoView(
                              controller: _photoViewController,
                              backgroundDecoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              imageProvider: AssetEntityImageProvider(
                                widget.assetEntity,
                              ),
                              initialScale:
                                  PhotoViewComputedScale.contained * 1,
                              minScale: PhotoViewComputedScale.contained * 1,
                              maxScale: PhotoViewComputedScale.covered * 2,
                            ),
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return StickerContainerWidget(
                                canvasWidth: constraints.maxWidth,
                                canvasHeight: constraints.maxHeight,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const EditorMaterialWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
