import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';
import '../game/neon_shooter_game.dart';
import 'enemy_component.dart';

class BulletComponent extends PositionComponent {
  final Bullet entity;
  final NeonShooterGame game;

  BulletComponent(this.entity, this.game) : super(
    position: Vector2(entity.position.dx, entity.position.dy),
    size: Vector2(entity.size.width, entity.size.height),
  );

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = entity.color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 3);
    
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.x, size.y),
      paint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Update entity
    entity.update();
    
    // Tracking logic
    if (entity.isTracking && entity.isPlayerBullet) {
      EnemyComponent? closestEnemy;
      double minDistance = double.infinity;
      for (final enemy in game.enemies) {
        if (enemy.entity.position.dy < entity.position.dy) {
          final distance = (enemy.entity.position - entity.position).distance;
          if (distance < minDistance) {
            minDistance = distance;
            closestEnemy = enemy;
          }
        }
      }

      if (closestEnemy != null) {
        final direction = (closestEnemy.entity.position - entity.position);
        final distance = direction.distance;
        if (distance > 0) {
          entity.velocity = direction / distance * 10;
        }
      }
    }
    
    // Remove if out of bounds
    if (entity.position.dy < -50 ||
        entity.position.dy > game.size.y + 50 ||
        entity.position.dx < -50 ||
        entity.position.dx > game.size.x + 50) {
      entity.shouldRemove = true;
    }
    
    // Update position
    position = Vector2(entity.position.dx, entity.position.dy);
  }
}
