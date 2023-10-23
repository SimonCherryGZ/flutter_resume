import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class DrawStarPainter extends CustomPainter {
  DrawStarPainter({
    required this.color,
    required this.strokeWidth,
    required this.progress,
  }) : super(repaint: progress);

  final Color color;
  final double strokeWidth;
  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final path = _getFiveStarPath(size.width / 2);
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

  Path _getFiveStarPath(double radius) {
    const initDegree = 180;
    final path = Path();
    final posOne = _getOffsetPosition(initDegree, radius);
    final posTwo = _getOffsetPosition(72 + initDegree, radius);
    final posThree = _getOffsetPosition(144 + initDegree, radius);
    final posFour = _getOffsetPosition(216 + initDegree, radius);
    final posFive = _getOffsetPosition(288 + initDegree, radius);
    path.moveTo(posOne.dx, posOne.dy);
    path.lineTo(posFour.dx, posFour.dy);
    path.lineTo(posTwo.dx, posTwo.dy);
    path.lineTo(posFive.dx, posFive.dy);
    path.lineTo(posThree.dx, posThree.dy);
    path.close();
    return path;
  }

  Offset _getOffsetPosition(int degree, double radius) {
    final radian = degree * pi / 180;
    final dx = sin(radian) * radius;
    final dy = cos(radian) * radius;
    return Offset(dx + radius, dy + radius);
  }
}
