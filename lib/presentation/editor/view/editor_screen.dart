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
    final screenSize = MediaQuery.sizeOf(context);
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
                      // todo - 裁掉空白区域
                      final scale = _photoViewController.scale ?? 1.0;
                      debugPrint('scale: $scale');
                      context.read<EditorBloc>().add(ExportImage());
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
                              imageProvider: AssetEntityImageProvider(
                                widget.assetEntity,
                                isOriginal: false,
                                thumbnailSize: ThumbnailSize(
                                  (screenSize.width * dp).toInt(),
                                  (screenSize.height * dp).toInt(),
                                ),
                                thumbnailFormat: ThumbnailFormat.jpeg,
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
