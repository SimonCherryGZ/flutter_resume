import 'dart:math';
import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';
import '../game/neon_shooter_game.dart';
import '../components/enemy_component.dart';
import '../components/item_component.dart';
import '../components/particle_component.dart';

class SpawnSystem {
  final NeonShooterGame game;
  final Random _random = Random();

  SpawnSystem(this.game);

  void update(int ticks) {
    // Spawn enemies
    if (ticks % 60 == 0 && game.enemies.length < 10 + game.wave * 2) {
      _spawnEnemy();
    }
  }

  void _spawnEnemy() {
    if (game.size.x == 0 || game.size.y == 0) return;

    double x = _random.nextDouble() * (game.size.x - 40);
    EnemyType type = EnemyType.normal;
    double hp = 20.0 + game.wave * 5;
    double speed = 2.0 + game.wave * 0.1;
    Color color = const Color(0xFFFF00FF); // Magenta
    int score = 10;

    int roll = _random.nextInt(100);
    if (roll < 5 && game.wave > 2) {
      type = EnemyType.boss;
      hp = 500.0 + game.wave * 50;
      speed = 1.0;
      color = const Color(0xFFFF0000); // Red
      score = 500;
      x = game.size.x / 2 - 40; // Center
    } else if (roll < 20 && game.wave > 0) {
      type = EnemyType.shooter;
      hp = 30.0 + game.wave * 5;
      speed = 1.5;
      color = const Color(0xFFFFFF00); // Yellow
      score = 30;
    } else if (roll < 40) {
      type = EnemyType.fast;
      hp = 10.0 + game.wave * 2;
      speed = 4.0 + game.wave * 0.2;
      color = const Color(0xFF00FF00); // Green
      score = 20;
    } else if (roll < 60 && game.wave > 1) {
      type = EnemyType.sine;
      hp = 25.0 + game.wave * 3;
      speed = 2.0 + game.wave * 0.1;
      color = Colors.purpleAccent;
      score = 25;
    } else if (roll < 80 && game.wave > 2) {
      type = EnemyType.tracker;
      hp = 20.0 + game.wave * 3;
      speed = 2.5;
      color = Colors.orangeAccent;
      score = 30;
    }

    final enemyEntity = Enemy(
      position: Offset(x, -50),
      size: type == EnemyType.boss ? const Size(80, 80) : const Size(40, 40),
      velocity: Offset(0, speed),
      color: color,
      hp: hp,
      maxHp: hp,
      enemyType: type,
      scoreValue: score,
      initialX: x,
    );

    final enemyComponent = EnemyComponent(enemyEntity, game);
    game.add(enemyComponent);
    game.enemies.add(enemyComponent);
  }

  void tryDropItem(Enemy enemy) {
    if (_random.nextInt(100) < 15) {
      // 15% chance
      ItemType type;
      WeaponType? weaponType;
      Color color = Colors.white;

      int roll = _random.nextInt(100);
      if (roll < 70) {
        // 70% of drops are weapons
        type = ItemType.weapon;
        final availableWeapons = WeaponType.values
            .where((w) => w != WeaponType.single)
            .toList();
        weaponType = availableWeapons[_random.nextInt(availableWeapons.length)];
        switch (weaponType) {
          case WeaponType.doubleGun:
            color = Colors.cyanAccent;
            break;
          case WeaponType.shotgun:
            color = Colors.redAccent;
            break;
          case WeaponType.piercing:
            color = Colors.yellowAccent;
            break;
          case WeaponType.tracking:
            color = Colors.greenAccent;
            break;
          default:
            color = Colors.orange;
            break;
        }
      } else if (roll < 85) {
        // 15% are shields
        type = ItemType.shield;
        color = Colors.blue;
      } else {
        // 15% are heals
        type = ItemType.heal;
        color = Colors.green;
      }

      final itemEntity = Item(
        position: enemy.position,
        size: const Size(20, 20),
        velocity: const Offset(0, 2),
        color: color,
        itemType: type,
        weaponType: weaponType,
      );

      final itemComponent = ItemComponent(itemEntity);
      game.add(itemComponent);
      game.items.add(itemComponent);
    }
  }

  void spawnEnemyDeathEffect(Enemy enemy) {
    final center = enemy.position + Offset(enemy.size.width / 2, enemy.size.height / 2);
    final color = enemy.color;

    // Outer ring shockwave
    const ringParticleCount = 20;
    for (int i = 0; i < ringParticleCount; i++) {
      final angle = (i / ringParticleCount) * 2 * pi;
      final speed = 3.0 + _random.nextDouble() * 2.0;
      final particleEntity = Particle(
        position: center,
        size: const Size(3, 3),
        velocity: Offset(cos(angle) * speed, sin(angle) * speed),
        color: color,
        life: 0.6,
        decay: 0.03,
      );
      final particleComponent = ParticleComponent(particleEntity);
      game.add(particleComponent);
      game.particles.add(particleComponent);
    }

    // Inner core explosion
    const coreParticleCount = 30;
    for (int i = 0; i < coreParticleCount; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = _random.nextDouble() * 3.0;
      final particleEntity = Particle(
        position: center,
        size: const Size(2, 2),
        velocity: Offset(cos(angle) * speed, sin(angle) * speed),
        color: Colors.white,
        life: 1.2,
        decay: 0.04 + _random.nextDouble() * 0.04,
      );
      final particleComponent = ParticleComponent(particleEntity);
      game.add(particleComponent);
      game.particles.add(particleComponent);
    }
  }

  void spawnExplosion(Offset position, Color color, int count) {
    for (int i = 0; i < count; i++) {
      double angle = _random.nextDouble() * 2 * pi;
      double speed = 1.0 + _random.nextDouble() * 3.0;
      final particleEntity = Particle(
        position: position,
        size: const Size(2, 2),
        velocity: Offset(cos(angle) * speed, sin(angle) * speed),
        color: color,
        life: 1.0,
        decay: 0.05 + _random.nextDouble() * 0.05,
      );
      final particleComponent = ParticleComponent(particleEntity);
      game.add(particleComponent);
      game.particles.add(particleComponent);
    }
  }
}
