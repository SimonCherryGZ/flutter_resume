import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_resume/utils/utils.dart';

class SampleGlobalKeyAccessScreen extends StatelessWidget {
  const SampleGlobalKeyAccessScreen({
    super.key,
    required this.globalKey,
  });

  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    const errorWidget = Text('Oops! Something went wrong...');
    final widgetSize = _getWidgetSizeFromGlobalKey(globalKey);
    Widget body = widgetSize == Size.zero
        ? errorWidget
        : _FutureBuilder(
            globalKey: globalKey,
            errorWidget: errorWidget,
            widgetSize: widgetSize,
          );
    return Scaffold(
      appBar: AppBar(
        title: const Text('GlobalKey Access'),
      ),
      body: Center(
        child: body,
      ),
    );
  }

  Size _getWidgetSizeFromGlobalKey(GlobalKey globalKey) {
    final context = globalKey.currentContext;
    if (context == null) {
      return Size.zero;
    }
    final renderObject = context.findRenderObject();
    if (renderObject == null || renderObject is! RenderBox) {
      return Size.zero;
    }
    return renderObject.size;
  }
}

class _FutureBuilder extends StatelessWidget {
  final GlobalKey globalKey;
  final Widget errorWidget;
  final Size widgetSize;

  const _FutureBuilder({
    required this.globalKey,
    required this.errorWidget,
    required this.widgetSize,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _captureWidgetFromGlobalKey(globalKey, context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final data = snapshot.data;
        if (data == null) {
          return errorWidget;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('通过 GlobalKey 找到上一个页面的目标 Widget\n然后对其截屏，以 Image 形式显示'),
            SizedBox(
              height: 20.ss(),
            ),
            Image.memory(
              data,
              width: widgetSize.width,
              height: widgetSize.height,
              fit: BoxFit.contain,
            ),
          ],
        );
      },
    );
  }

  Future<Uint8List?> _captureWidgetFromGlobalKey(
      GlobalKey globalKey, BuildContext context) async {
    final context = globalKey.currentContext;
    if (context == null) {
      return null;
    }
    final renderObject = context.findRenderObject();
    if (renderObject == null || renderObject is! RenderRepaintBoundary) {
      return null;
    }
    RenderRepaintBoundary renderRepaintBoundary = renderObject;
    final image = await renderRepaintBoundary.toImage(
      pixelRatio: MediaQuery.devicePixelRatioOf(context),
    );
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      return null;
    }
    return byteData.buffer.asUint8List();
  }
}
