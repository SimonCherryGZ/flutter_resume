import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PointerPositionPainter extends CustomPainter {
  PointerPositionPainter(this.position) : super(repaint: position);

  final ValueListenable<Offset> position;

  @override
  void paint(Canvas canvas, Size size) {
    final offset = position.value;
    canvas.drawCircle(
      offset,
      10.0,
      Paint()..color = Colors.black,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
