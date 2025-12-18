import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';

class ItemComponent extends PositionComponent {
  final Item entity;

  ItemComponent(this.entity) : super(
    position: Vector2(entity.position.dx, entity.position.dy),
    size: Vector2(entity.size.width, entity.size.height),
  );

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = entity.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5);

    final center = Vector2(size.x / 2, size.y / 2);
    final radius = size.x / 2;

    canvas.drawCircle(Offset(center.x, center.y), radius, paint);

    // Symbol inside
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    if (entity.itemType == ItemType.weapon) {
      String letter = 'W';
      switch (entity.weaponType) {
        case WeaponType.doubleGun:
          letter = 'D';
          break;
        case WeaponType.shotgun:
          letter = 'S';
          break;
        case WeaponType.piercing:
          letter = 'P';
          break;
        case WeaponType.tracking:
          letter = 'T';
          break;
        default:
          letter = 'W';
          break;
      }
      textPainter.text = TextSpan(
        text: letter,
        style: TextStyle(
          color: entity.color,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      IconData icon;
      if (entity.itemType == ItemType.heal) {
        icon = Icons.local_hospital;
      } else {
        // Shield
        icon = Icons.shield;
      }
      
      textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          color: entity.color,
          fontSize: 16,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
      );
    }

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.x - textPainter.width / 2,
        center.y - textPainter.height / 2,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Update entity
    entity.update();
    
    // Update position
    position = Vector2(entity.position.dx, entity.position.dy);
  }
}
