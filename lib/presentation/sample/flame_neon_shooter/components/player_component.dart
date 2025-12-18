import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';
import '../game/neon_shooter_game.dart';

class PlayerComponent extends PositionComponent {
  final Player entity;
  final NeonShooterGame game;
  int lastHitTick = 0;

  PlayerComponent(this.entity, this.game) : super(
    position: Vector2(entity.position.dx, entity.position.dy),
    size: Vector2(entity.size.width, entity.size.height),
  );

  @override
  void render(Canvas canvas) {
    Color color = entity.color;
    if (game.ticks - lastHitTick < 5) {
      // Flash white when hit
      color = Colors.white;
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5);

    final center = Vector2(size.x / 2, size.y / 2);
    final halfW = size.x / 2;
    final halfH = size.y / 2;

    // Triangle shape
    final path = Path();
    path.moveTo(center.x, center.y - halfH);
    path.lineTo(center.x - halfW, center.y + halfH);
    path.lineTo(center.x, center.y + halfH * 0.5);
    path.lineTo(center.x + halfW, center.y + halfH);
    path.close();

    canvas.drawPath(path, paint);

    // Shield
    if (entity.hasShield) {
      final shieldPaint = Paint()
        ..color = Colors.cyan.withOpacity(0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
      canvas.drawCircle(Offset(center.x, center.y), max(halfW, halfH) + 10, shieldPaint);
      
      final shieldBorderPaint = Paint()
        ..color = Colors.cyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(Offset(center.x, center.y), max(halfW, halfH) + 10, shieldBorderPaint);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update position from entity
    position = Vector2(entity.position.dx, entity.position.dy);
  }
}
