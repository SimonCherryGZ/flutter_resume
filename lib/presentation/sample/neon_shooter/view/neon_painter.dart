import 'dart:math';

import 'package:flutter/material.dart';
import '../bloc/neon_shooter_bloc.dart';
import '../model/game_entity.dart';

class NeonPainter extends CustomPainter {
  final NeonShooterState state;

  NeonPainter(this.state);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw Background (Starfield or Grid)
    _drawBackground(canvas, size);

    // Draw Player
    if (state.status != NeonShooterStatus.gameOver) {
      _drawPlayer(canvas, state.player);
    }

    // Draw Enemies
    for (final enemy in state.enemies) {
      _drawEnemy(canvas, enemy);
    }

    // Draw Bullets
    for (final bullet in state.bullets) {
      _drawBullet(canvas, bullet);
    }

    // Draw Items
    for (final item in state.items) {
      _drawItem(canvas, item);
    }
  }

  void _drawBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, paint);

    // Grid
    final gridPaint = Paint()
      ..color = Colors.purple.withOpacity(0.2)
      ..strokeWidth = 1;
    
    const double gridSize = 50;
    // Moving grid effect could be added here using a time offset if available in state
    
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawPlayer(Canvas canvas, Player player) {
    final paint = Paint()
      ..color = player.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5);

    final path = Path();
    final center = player.position + Offset(player.size.width / 2, player.size.height / 2);
    final halfW = player.size.width / 2;
    final halfH = player.size.height / 2;

    // Triangle shape
    path.moveTo(center.dx, center.dy - halfH);
    path.lineTo(center.dx - halfW, center.dy + halfH);
    path.lineTo(center.dx, center.dy + halfH * 0.5);
    path.lineTo(center.dx + halfW, center.dy + halfH);
    path.close();

    canvas.drawPath(path, paint);

    // Shield
    if (player.hasShield) {
      final shieldPaint = Paint()
        ..color = Colors.blue.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);
      canvas.drawCircle(center, max(halfW, halfH) + 5, shieldPaint);
    }
  }

  void _drawEnemy(Canvas canvas, Enemy enemy) {
    final paint = Paint()
      ..color = enemy.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5);

    final center = enemy.position + Offset(enemy.size.width / 2, enemy.size.height / 2);
    final halfW = enemy.size.width / 2;
    final halfH = enemy.size.height / 2;

    switch (enemy.enemyType) {
      case EnemyType.normal:
        canvas.drawRect(enemy.rect, paint);
        break;
      case EnemyType.fast:
        // Diamond
        final path = Path();
        path.moveTo(center.dx, center.dy - halfH);
        path.lineTo(center.dx + halfW, center.dy);
        path.lineTo(center.dx, center.dy + halfH);
        path.lineTo(center.dx - halfW, center.dy);
        path.close();
        canvas.drawPath(path, paint);
        break;
      case EnemyType.shooter:
        // Hexagon-ish
        final path = Path();
        path.moveTo(center.dx - halfW * 0.5, center.dy - halfH);
        path.lineTo(center.dx + halfW * 0.5, center.dy - halfH);
        path.lineTo(center.dx + halfW, center.dy);
        path.lineTo(center.dx + halfW * 0.5, center.dy + halfH);
        path.lineTo(center.dx - halfW * 0.5, center.dy + halfH);
        path.lineTo(center.dx - halfW, center.dy);
        path.close();
        canvas.drawPath(path, paint);
        break;
      case EnemyType.boss:
        // Complex shape or just big rect with details
        canvas.drawRect(enemy.rect, paint);
        canvas.drawCircle(center, halfW * 0.5, paint);
        break;
    }

    // HP Bar for Boss
    if (enemy.enemyType == EnemyType.boss) {
      final hpPercent = enemy.hp / enemy.maxHp;
      final hpBarRect = Rect.fromLTWH(
        enemy.position.dx, 
        enemy.position.dy - 10, 
        enemy.size.width * hpPercent, 
        5
      );
      canvas.drawRect(hpBarRect, Paint()..color = Colors.red);
    }
  }

  void _drawBullet(Canvas canvas, Bullet bullet) {
    final paint = Paint()
      ..color = bullet.color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 3);
    
    canvas.drawOval(bullet.rect, paint);
  }

  void _drawItem(Canvas canvas, Item item) {
    final paint = Paint()
      ..color = item.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5);

    final center = item.position + Offset(item.size.width / 2, item.size.height / 2);
    final radius = item.size.width / 2;

    canvas.drawCircle(center, radius, paint);

    // Symbol inside
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    String symbol = '';
    switch (item.itemType) {
      case ItemType.weapon: symbol = 'W'; break;
      case ItemType.shield: symbol = 'S'; break;
      case ItemType.heal: symbol = 'H'; break;
    }

    textPainter.text = TextSpan(
      text: symbol,
      style: TextStyle(color: item.color, fontSize: 12, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant NeonPainter oldDelegate) {
    return true; // Always repaint for game loop
  }
}
