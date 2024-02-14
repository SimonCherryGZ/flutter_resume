import 'dart:math';

import 'package:flutter/widgets.dart';

class ColorArcPainter extends CustomPainter {
  final ColorArcPainterData data;

  ColorArcPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final lineWidth = data.lineWidth;
    final lineColor = data.lineColor;
    final percent = data.percent;
    final startType = data.startType;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - lineWidth / 2;
    double sweepAngle = 2 * pi * (percent / 100);
    double startAngle = pi / 2;
    if (startType == 2) {
      startAngle = -pi / 2;
    } else if (startType == 3) {
      startAngle = pi;
    } else if (startType == 4) {
      startAngle = pi * 2;
    }

    Paint paint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is! ColorArcPainter) {
      return false;
    }
    return data != oldDelegate.data;
  }
}

class ColorArcPainterData {
  // 从哪开始：1 从下开始；2 从上开始；3 从左开始；4 从右开始
  final double startType;
  final Color lineColor;
  final double lineWidth;
  final double percent;

  ColorArcPainterData({
    required this.lineColor,
    required this.lineWidth,
    this.startType = 1,
    required this.percent,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorArcPainterData &&
          runtimeType == other.runtimeType &&
          startType == other.startType &&
          lineColor == other.lineColor &&
          lineWidth == other.lineWidth &&
          percent == other.percent;

  @override
  int get hashCode =>
      startType.hashCode ^
      lineColor.hashCode ^
      lineWidth.hashCode ^
      percent.hashCode;
}
