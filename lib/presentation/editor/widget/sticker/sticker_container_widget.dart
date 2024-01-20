import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';

class StickerContainerWidget extends StatelessWidget {
  const StickerContainerWidget({
    super.key,
    required this.canvasWidth,
    required this.canvasHeight,
  });

  final double canvasWidth;
  final double canvasHeight;

  @override
  Widget build(BuildContext context) {
    final editRect = Rect.fromLTWH(0, 0, canvasWidth, canvasHeight);
    // final paddingTop = MediaQuery.of(context).padding.top;
    // final appBarHeight = AppBar().preferredSize.height;
    // final offsetY = paddingTop + appBarHeight;
    // final offset = Offset(0, offsetY);
    const offset = Offset.zero;
    return BlocProvider(
      create: (context) => StickerContainerBloc(
        editRect: editRect,
        offset: offset,
      ),
      child: Builder(builder: (context) {
        final bloc = context.read<StickerContainerBloc>();

        RawGestureDetector gestureDetectorTwo = GestureDetector(
          child: GestureDetector(
            onPanUpdate: (details) {
              bloc.add(PanUpdate(details));
            },
            behavior: HitTestBehavior.deferToChild,
            child: BlocBuilder<StickerContainerBloc, StickerContainerState>(
              builder: (context, state) {
                return Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ...state.elements.map((e) {
                      return e.buildTransform();
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ).build(context) as RawGestureDetector;

        gestureDetectorTwo.gestures[RotateScaleGestureRecognizer] =
            GestureRecognizerFactoryWithHandlers<RotateScaleGestureRecognizer>(
          () => RotateScaleGestureRecognizer(debugOwner: this),
          (RotateScaleGestureRecognizer instance) {
            instance
              ..onStart = (details) {
                bloc.add(DoubleFingerScaleAndRotateStart(details));
              }
              ..onUpdate = (details) {
                bloc.add(DoubleFingerScaleAndRotateProcess(details));
              }
              ..onEnd = (details) {
                bloc.add(DoubleFingerScaleAndRotateEnd(details));
              };
          },
        );

        return BlocListener<EditorBloc, EditorState>(
          listener: (context, state) {
            final imagePath = state.imagePath;
            final width = state.width;
            final height = state.height;
            if (imagePath == null || width == null || height == null) {
              return;
            }
            bloc.add(AddAssetStickerToContainer(
              imagePath: imagePath,
              width: width,
              height: height,
            ));
          },
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              bloc.add(PointerDown(event));
            },
            onPointerUp: (event) {
              bloc.add(PointerUp(event));
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: double.infinity,
                minWidth: double.infinity,
              ),
              child: gestureDetectorTwo,
            ),
          ),
        );
      }),
    );
  }
}
