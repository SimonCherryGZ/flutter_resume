import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class ActionTipsWidget extends StatefulWidget {
  const ActionTipsWidget({super.key});

  @override
  State<ActionTipsWidget> createState() => _ActionTipsWidgetState();
}

class _ActionTipsWidgetState extends State<ActionTipsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = sin(_controller.value);
        return Transform.translate(
          offset: Offset(0, value * 10.ss()),
          child: child,
        );
      },
      child: Column(
        children: [
          UnconstrainedBox(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.ss(),
                vertical: 10.ss(),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.ss()),
                color: Colors.black.withValues(alpha: 0.75),
              ),
              child: const Center(
                child: Text(
                  'Click 👇 Here',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.ss(),
            height: 6.ss(),
            child: CustomPaint(
              painter: _TrianglePainter(
                strokeColor: Colors.black.withValues(alpha: 0.75),
                paintingStyle: PaintingStyle.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;

  _TrianglePainter({
    this.strokeColor = Colors.black,
    this.paintingStyle = PaintingStyle.stroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..style = paintingStyle;
    canvas.drawPath(
      _getTrianglePath(size.width, size.height),
      paint,
    );
  }

  Path _getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x / 2, y)
      ..lineTo(x, 0)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle;
  }
}
