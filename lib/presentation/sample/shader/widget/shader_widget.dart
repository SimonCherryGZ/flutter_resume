import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/shader/entity/abs_filter.dart';

typedef OnDraw = void Function(
  Canvas canvas,
  Size canvasSize,
  ui.FragmentShader shader,
);

typedef ShouldRepaint = bool Function();

class ShaderWidget extends StatelessWidget {
  const ShaderWidget({
    super.key,
    required this.layoutSize,
    required this.contentSize,
    required this.filter,
    this.loadingBuilder,
  });

  final Size layoutSize;
  final Size contentSize;
  final AbsFilter filter;
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: filter.loadShader(),
      builder: (context, snapshot) {
        final shader = snapshot.data;
        if (shader == null) {
          return Center(
            child: loadingBuilder?.call(context) ??
                const CircularProgressIndicator(),
          );
        }
        return ClipRect(
          child: CustomPaint(
            size: layoutSize,
            painter: _ShaderPainter(
              shader: shader,
              onDraw: (canvas, layoutSize, shader) {
                filter.draw(canvas, layoutSize, contentSize, shader);
              },
            ),
          ),
        );
      },
    );
  }
}

class _ShaderPainter extends CustomPainter {
  _ShaderPainter({
    required this.shader,
    this.onDraw,
  });

  final ui.FragmentShader shader;
  final OnDraw? onDraw;

  @override
  void paint(Canvas canvas, Size size) {
    if (onDraw != null) {
      onDraw?.call(canvas, size, shader);
      return;
    }
    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
