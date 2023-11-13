import 'dart:math';

import 'package:flutter/material.dart';

class ExpensivePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Random rand = Random(12345);
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.green,
      Colors.white,
    ];
    final paint = Paint();
    for (int i = 0; i < 5000; i++) {
      final x = rand.nextDouble() * (size.width - 60) + 30;
      final y = rand.nextDouble() * (size.height - 60) + 30;
      final radius = rand.nextDouble() * 20 + 10;
      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint..color = colors[rand.nextInt(colors.length)].withOpacity(0.2),
      );
    }
  }

  @override
  bool shouldRepaint(ExpensivePainter oldDelegate) => false;
}
