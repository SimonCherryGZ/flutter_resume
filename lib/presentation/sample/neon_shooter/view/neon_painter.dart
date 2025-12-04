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

    // Draw Particles
    for (final particle in state.particles) {
      _drawParticle(canvas, particle);
    }
  }

  void _drawBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, paint);

    // Draw Starfield
    final random = Random(42); // Fixed seed for consistent star positions
    const int starCount = 100;
    
    for (int i = 0; i < starCount; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double speed = 1.0 + random.nextDouble() * 4.0; // Different speeds for parallax
      double sizeVal = 1.0 + random.nextDouble() * 2.0;
      double opacity = 0.1 + random.nextDouble() * 0.3;

      // Animate y
      y = (y + state.ticks * speed) % size.height;

      final starPaint = Paint()
        ..color = Colors.white.withOpacity(opacity)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(Offset(x, y), sizeVal, starPaint);
    }

    // Grid (Moving)
    final gridPaint = Paint()
      ..color = Colors.purple.withOpacity(0.2)
      ..strokeWidth = 1;
    
    const double gridSize = 50;
    double gridOffsetY = (state.ticks * 2.0) % gridSize;
    
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = -gridSize; y < size.height; y += gridSize) {
      double drawY = y + gridOffsetY;
      if (drawY >= 0 && drawY <= size.height) {
        canvas.drawLine(Offset(0, drawY), Offset(size.width, drawY), gridPaint);
      }
    }
  }

  void _drawPlayer(Canvas canvas, Player player) {
    Color color = player.color;
    if (state.ticks - player.lastHitTick < 5) {
      color = Colors.white;
    }

    final paint = Paint()
      ..color = color
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
        ..color = Colors.cyan.withOpacity(0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
      canvas.drawCircle(center, max(halfW, halfH) + 10, shieldPaint);
      
      final shieldBorderPaint = Paint()
        ..color = Colors.cyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(center, max(halfW, halfH) + 10, shieldBorderPaint);
    }
  }

  void _drawEnemy(Canvas canvas, Enemy enemy) {
    Color color = enemy.color;
    if (state.ticks - enemy.lastHitTick < 5) {
      color = Colors.white;
    }

    final paint = Paint()
      ..color = color
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
      case EnemyType.sine:
        // Wave shape
        final path = Path();
        path.moveTo(center.dx - halfW, center.dy - halfH);
        path.quadraticBezierTo(center.dx, center.dy, center.dx + halfW, center.dy - halfH);
        path.quadraticBezierTo(center.dx, center.dy, center.dx - halfW, center.dy + halfH);
        path.quadraticBezierTo(center.dx, center.dy, center.dx + halfW, center.dy + halfH);
        canvas.drawPath(path, paint);
        break;
      case EnemyType.tracker:
        // Arrow shape
        final path = Path();
        path.moveTo(center.dx, center.dy + halfH);
        path.lineTo(center.dx - halfW, center.dy - halfH);
        path.lineTo(center.dx, center.dy - halfH * 0.5);
        path.lineTo(center.dx + halfW, center.dy - halfH);
        path.close();
        
        // Rotate towards velocity
        canvas.save();
        canvas.translate(center.dx, center.dy);
        double angle = atan2(enemy.velocity.dy, enemy.velocity.dx) - pi / 2;
        canvas.rotate(angle);
        canvas.translate(-center.dx, -center.dy);
        canvas.drawPath(path, paint);
        canvas.restore();
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

  void _drawParticle(Canvas canvas, Particle particle) {
    final paint = Paint()
      ..color = particle.color.withOpacity(particle.life)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(particle.position, particle.size.width, paint);
  }

  @override
  bool shouldRepaint(covariant NeonPainter oldDelegate) {
    return true; // Always repaint for game loop
  }
}
