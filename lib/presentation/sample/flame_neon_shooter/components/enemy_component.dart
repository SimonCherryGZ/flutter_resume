import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';
import '../game/neon_shooter_game.dart';

class EnemyComponent extends PositionComponent {
  final Enemy entity;
  final NeonShooterGame game;
  int lastHitTick = 0;

  EnemyComponent(this.entity, this.game) : super(
    position: Vector2(entity.position.dx, entity.position.dy),
    size: Vector2(entity.size.width, entity.size.height),
  );

  @override
  void render(Canvas canvas) {
    Color color = entity.color;
    if (game.ticks - lastHitTick < 5) {
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

    switch (entity.enemyType) {
      case EnemyType.normal:
        canvas.drawRect(
          Rect.fromLTWH(0, 0, size.x, size.y),
          paint,
        );
        break;
      case EnemyType.fast:
        // Diamond
        final path = Path();
        path.moveTo(center.x, center.y - halfH);
        path.lineTo(center.x + halfW, center.y);
        path.lineTo(center.x, center.y + halfH);
        path.lineTo(center.x - halfW, center.y);
        path.close();
        canvas.drawPath(path, paint);
        break;
      case EnemyType.shooter:
        // Hexagon-ish
        final path = Path();
        path.moveTo(center.x - halfW * 0.5, center.y - halfH);
        path.lineTo(center.x + halfW * 0.5, center.y - halfH);
        path.lineTo(center.x + halfW, center.y);
        path.lineTo(center.x + halfW * 0.5, center.y + halfH);
        path.lineTo(center.x - halfW * 0.5, center.y + halfH);
        path.lineTo(center.x - halfW, center.y);
        path.close();
        canvas.drawPath(path, paint);
        break;
      case EnemyType.boss:
        // Complex shape
        canvas.drawRect(
          Rect.fromLTWH(0, 0, size.x, size.y),
          paint,
        );
        canvas.drawCircle(Offset(center.x, center.y), halfW * 0.5, paint);
        break;
      case EnemyType.sine:
        // Wave shape
        final path = Path();
        path.moveTo(center.x - halfW, center.y - halfH);
        path.quadraticBezierTo(center.x, center.y, center.x + halfW, center.y - halfH);
        path.quadraticBezierTo(center.x, center.y, center.x - halfW, center.y + halfH);
        path.quadraticBezierTo(center.x, center.y, center.x + halfW, center.y + halfH);
        canvas.drawPath(path, paint);
        break;
      case EnemyType.tracker:
        // Arrow shape
        final path = Path();
        path.moveTo(center.x, center.y + halfH);
        path.lineTo(center.x - halfW, center.y - halfH);
        path.lineTo(center.x, center.y - halfH * 0.5);
        path.lineTo(center.x + halfW, center.y - halfH);
        path.close();
        
        // Rotate towards velocity
        canvas.save();
        canvas.translate(center.x, center.y);
        double angle = atan2(entity.velocity.dy, entity.velocity.dx) - pi / 2;
        canvas.rotate(angle);
        canvas.translate(-center.x, -center.y);
        canvas.drawPath(path, paint);
        canvas.restore();
        break;
    }

    // HP Bar for Boss
    if (entity.enemyType == EnemyType.boss) {
      final hpPercent = entity.hp / entity.maxHp;
      final hpBarRect = Rect.fromLTWH(
        0,
        -10,
        size.x * hpPercent,
        5,
      );
      canvas.drawRect(hpBarRect, Paint()..color = Colors.red);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Update entity
    entity.update();
    
    // AI Movement
    if (entity.enemyType == EnemyType.boss) {
      // Boss logic: hover at top, move side to side
      if (entity.position.dy < 100) {
        entity.velocity = const Offset(0, 1);
      } else {
        entity.velocity = Offset(sin(game.ticks * 0.05) * 2, 0);
      }
    } else if (entity.enemyType == EnemyType.sine) {
      // Sine wave movement
      double newY = entity.position.dy + entity.velocity.dy;
      double newX = entity.initialX + sin(game.ticks * 0.1) * 100;
      newX = newX.clamp(0.0, game.size.x - entity.size.width);
      entity.position = Offset(newX, newY);
    } else if (entity.enemyType == EnemyType.tracker) {
      // Track player
      if (game.player != null) {
        Offset direction = (game.player!.entity.position - entity.position);
        double distance = direction.distance;
        if (distance > 0) {
          direction = direction / distance;
          entity.velocity = direction * 2.5;
        }
      }
    }
    
    // Remove if out of bounds
    if (entity.position.dy > game.size.y) {
      entity.shouldRemove = true;
    }
    
    // Update position
    position = Vector2(entity.position.dx, entity.position.dy);
  }
}
