import 'dart:ui';

import 'package:flutter/material.dart';

class DrawCurvePainter extends CustomPainter {
  DrawCurvePainter({
    required this.curve,
    required this.progress,
    required this.color,
    required this.strokeWidth,
  }) : super(repaint: progress);

  final Curve curve;
  final Animation<double> progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final points = <Offset>[];
    for (int i = 0; i < 100; i++) {
      double dx = i / 100.0;
      double dy = 1 - curve.transform(dx);
      points.add(Offset(dx * size.width, dy * size.height));
    }
    final path = Path();
    for (int i = 0; i < 100; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      } else {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }
    PathMetrics pms = path.computeMetrics();
    for (final pm in pms) {
      Path extractPath = pm.extractPath(0.0, pm.length * progress.value);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
