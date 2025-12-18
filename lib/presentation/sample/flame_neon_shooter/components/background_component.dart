import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../game/neon_shooter_game.dart';

class BackgroundComponent extends Component {
  final NeonShooterGame game;
  int _ticks = 0;
  final Random _random = Random(42); // Fixed seed for consistent star positions
  static const int starCount = 100;
  final List<_Star> _stars = [];

  BackgroundComponent(this.game) {
    // Initialize stars
    for (int i = 0; i < starCount; i++) {
      _stars.add(_Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        speed: 1.0 + _random.nextDouble() * 4.0,
        size: 1.0 + _random.nextDouble() * 2.0,
        opacity: 0.1 + _random.nextDouble() * 0.3,
      ));
    }
  }

  void updateTicks(int ticks) {
    _ticks = ticks;
  }

  @override
  void render(Canvas canvas) {
    final size = game.size;

    // Draw black background
    final bgPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      bgPaint,
    );

    // Draw stars
    for (final star in _stars) {
      double x = star.x * size.x;
      double y = (star.y * size.y + _ticks * star.speed) % size.y;

      final starPaint = Paint()
        ..color = Colors.white.withValues(alpha: star.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), star.size, starPaint);
    }

    // Draw grid
    final gridPaint = Paint()
      ..color = Colors.purple.withValues(alpha: 0.2)
      ..strokeWidth = 1;

    const double gridSize = 50;
    double gridOffsetY = (_ticks * 2.0) % gridSize;

    for (double x = 0; x < size.x; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.y), gridPaint);
    }
    for (double y = -gridSize; y < size.y; y += gridSize) {
      double drawY = y + gridOffsetY;
      if (drawY >= 0 && drawY <= size.y) {
        canvas.drawLine(Offset(0, drawY), Offset(size.x, drawY), gridPaint);
      }
    }
  }
}

class _Star {
  final double x;
  final double y;
  final double speed;
  final double size;
  final double opacity;

  _Star({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.opacity,
  });
}
