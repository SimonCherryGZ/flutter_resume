import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';

class ParticleComponent extends PositionComponent {
  final Particle entity;

  ParticleComponent(this.entity) : super(
    position: Vector2(entity.position.dx, entity.position.dy),
    size: Vector2(entity.size.width, entity.size.height),
  );

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = entity.color.withOpacity(entity.life.clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x,
      paint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Update entity
    entity.update();
    entity.life -= entity.decay;
    
    if (entity.life <= 0) {
      entity.shouldRemove = true;
    }
    
    // Update position
    position = Vector2(entity.position.dx, entity.position.dy);
  }
}
