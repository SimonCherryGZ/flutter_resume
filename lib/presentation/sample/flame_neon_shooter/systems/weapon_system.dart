import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';
import '../game/neon_shooter_game.dart';
import '../components/bullet_component.dart';

class WeaponSystem {
  final NeonShooterGame game;

  WeaponSystem(this.game);

  void firePlayerBullet(Player player) {
    const double bulletDamage = 20.0;
    const Color bulletColor = Color(0xFF00FFFF);
    const Size bulletSize = Size(10, 20);

    switch (player.weaponType) {
      case WeaponType.single:
        _createBullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -10),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        );
        break;
      case WeaponType.doubleGun:
        _createBullet(
          position: player.position + Offset(player.size.width / 4 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -10),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        );
        _createBullet(
          position: player.position + Offset(player.size.width * 3 / 4 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -10),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        );
        break;
      case WeaponType.shotgun:
        _createBullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -10),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        );
        _createBullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(-3, -9),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        );
        _createBullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(3, -9),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        );
        break;
      case WeaponType.piercing:
        _createBullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -12),
          color: Colors.yellow,
          damage: bulletDamage,
          isPlayerBullet: true,
          isPiercing: true,
        );
        break;
      case WeaponType.tracking:
        _createBullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -8),
          color: Colors.greenAccent,
          damage: bulletDamage,
          isPlayerBullet: true,
          isTracking: true,
        );
        break;
    }
  }

  void fireEnemyBullet(Enemy enemy, Player? player) {
    if (player == null) return;

    Offset direction = (player.position - enemy.position);
    double distance = direction.distance;
    if (distance == 0) return;
    direction = direction / distance;

    _createBullet(
      position: enemy.position + Offset(enemy.size.width / 2 - 5, enemy.size.height),
      size: const Size(10, 10),
      velocity: direction * 5,
      color: enemy.color,
      damage: 10,
      isPlayerBullet: false,
    );
  }

  void _createBullet({
    required Offset position,
    required Size size,
    required Offset velocity,
    required Color color,
    required double damage,
    required bool isPlayerBullet,
    bool isPiercing = false,
    bool isTracking = false,
  }) {
    final bulletEntity = Bullet(
      position: position,
      size: size,
      velocity: velocity,
      color: color,
      damage: damage,
      isPlayerBullet: isPlayerBullet,
      isPiercing: isPiercing,
      isTracking: isTracking,
    );

    final bulletComponent = BulletComponent(bulletEntity, game);
    game.add(bulletComponent);
    game.bullets.add(bulletComponent);
  }
}
