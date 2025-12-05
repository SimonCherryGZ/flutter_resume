import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/game_entity.dart';

part 'neon_shooter_event.dart';

part 'neon_shooter_state.dart';

class NeonShooterBloc extends Bloc<NeonShooterEvent, NeonShooterState> {
  Timer? _gameTimer;
  final Random _random = Random();
  int _ticks = 0;

  NeonShooterBloc() : super(NeonShooterState.initial()) {
    on<NeonShooterInitEvent>(_onInit);
    on<NeonShooterUpdateEvent>(_onUpdate);
    on<NeonShooterMovePlayerEvent>(_onMovePlayer);
    on<NeonShooterRestartEvent>(_onRestart);
    on<NeonShooterResizeEvent>(_onResize);
  }

  @override
  Future<void> close() {
    _gameTimer?.cancel();
    return super.close();
  }

  void _onResize(NeonShooterResizeEvent event, Emitter<NeonShooterState> emit) {
    if (state.screenSize == Size.zero) {
      emit(state.copyWith(screenSize: event.size));
      if (state.status == NeonShooterStatus.initial) {
        add(NeonShooterRestartEvent());
      }
    } else {
      emit(state.copyWith(screenSize: event.size));
    }
  }

  void _onInit(NeonShooterInitEvent event, Emitter<NeonShooterState> emit) {
    // Screen size will be updated from the view, for now assume a default or wait for update
    // Actually, we need screen size to position player.
    // Let's assume a standard size and update it later or pass it in init.
    // For simplicity, we'll start game loop and let view update size via a resize event if needed,
    // but here we just assume a fixed size for logic or handle it dynamically.
    // Better: View passes screen size in Init.
    // Let's modify Init to take size, or just handle it in the first update.
    // We will use a fixed logical size for game logic to be consistent?
    // No, full screen is better.
    // Let's assume the View will set the screen size in the state soon.

    _startGameLoop(emit);
  }

  void _startGameLoop(Emitter<NeonShooterState> emit) {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      add(NeonShooterUpdateEvent());
    });
  }

  void _onRestart(
      NeonShooterRestartEvent event, Emitter<NeonShooterState> emit) {
    final screenSize = state.screenSize;
    emit(NeonShooterState.initial().copyWith(
      status: NeonShooterStatus.playing,
      screenSize: screenSize,
      player: Player(
        position: Offset(screenSize.width / 2, screenSize.height - 100),
        size: const Size(40, 40),
        velocity: Offset.zero,
        color: const Color(0xFF00FFFF),
      ),
    ));
    _ticks = 0;
  }

  void _onMovePlayer(
      NeonShooterMovePlayerEvent event, Emitter<NeonShooterState> emit) {
    if (state.status != NeonShooterStatus.playing) return;

    final player = state.player;
    double newX = player.position.dx + event.delta.dx;
    double newY = player.position.dy + event.delta.dy;

    // Clamp to screen
    newX = newX.clamp(0.0, state.screenSize.width - player.size.width);
    newY = newY.clamp(0.0, state.screenSize.height - player.size.height);

    player.position = Offset(newX, newY);
    emit(state.copyWith(player: player));
  }

  void _onUpdate(NeonShooterUpdateEvent event, Emitter<NeonShooterState> emit) {
    if (state.status != NeonShooterStatus.playing) return;

    _ticks++;
    final player = state.player;
    final enemies = List<Enemy>.from(state.enemies);
    final bullets = List<Bullet>.from(state.bullets);
    final items = List<Item>.from(state.items);
    final particles = List<Particle>.from(state.particles);
    final screenSize = state.screenSize;

    // 1. Spawn Enemies
    if (_ticks % 60 == 0 && enemies.length < 10 + state.wave * 2) {
      _spawnEnemy(enemies, screenSize, state.wave);
    }

    // 2. Player Fire
    if (_ticks % 15 == 0) {
      _fireBullet(player, bullets);
    }

    // 3. Enemy Fire
    for (final enemy in enemies) {
      if (enemy.enemyType == EnemyType.shooter ||
          enemy.enemyType == EnemyType.boss) {
        if (_random.nextInt(100) < 2) {
          // 2% chance per frame
          _enemyFire(enemy, bullets, player);
        }
      }
    }

    // 4. Update Entities
    for (final enemy in enemies) {
      enemy.update();
      // AI Movement
      if (enemy.enemyType == EnemyType.boss) {
        // Boss logic: hover at top, move side to side
        if (enemy.position.dy < 100) {
          enemy.velocity = const Offset(0, 1);
        } else {
          enemy.velocity = Offset(sin(_ticks * 0.05) * 2, 0);
        }
      } else if (enemy.enemyType == EnemyType.sine) {
        // Sine wave movement
        double newY = enemy.position.dy + enemy.velocity.dy;
        double newX = enemy.initialX + sin(_ticks * 0.1) * 100; // Amplitude 100
        // Clamp X to screen
        newX = newX.clamp(0.0, screenSize.width - enemy.size.width);
        enemy.position = Offset(newX, newY);
      } else if (enemy.enemyType == EnemyType.tracker) {
        // Track player
        Offset direction = (player.position - enemy.position);
        double distance = direction.distance;
        if (distance > 0) {
          direction = direction / distance;
          // Move towards player but keep some forward momentum or just direct tracking?
          // Let's do direct tracking with constant speed
          enemy.velocity = direction * 2.5; // Speed 2.5
        }
      } else {
        // Normal enemies move down
        if (enemy.position.dy > screenSize.height) {
          enemy.shouldRemove = true;
        }
      }
    }

    for (final bullet in bullets) {
      bullet.update();

      if (bullet.isTracking && bullet.isPlayerBullet) {
        Enemy? closestEnemy;
        double minDistance = double.infinity;
        for (final enemy in enemies) {
          if (enemy.position.dy < bullet.position.dy) {
            final distance = (enemy.position - bullet.position).distance;
            if (distance < minDistance) {
              minDistance = distance;
              closestEnemy = enemy;
            }
          }
        }

        if (closestEnemy != null) {
          final direction =
              (closestEnemy.position - bullet.position).normalized();
          bullet.velocity = direction * 10;
        }
      }

      if (bullet.position.dy < -50 ||
          bullet.position.dy > screenSize.height + 50 ||
          bullet.position.dx < -50 ||
          bullet.position.dx > screenSize.width + 50) {
        bullet.shouldRemove = true;
      }
    }

    for (final item in items) {
      item.update();
      if (item.position.dy > screenSize.height) {
        item.shouldRemove = true;
      }
    }

    for (final particle in particles) {
      particle.update();
      particle.life -= particle.decay;
      if (particle.life <= 0) {
        particle.shouldRemove = true;
      }
    }

    // 5. Collision Detection
    // Player Bullets hit Enemies
    for (final bullet in bullets.where((b) => b.isPlayerBullet)) {
      for (final enemy in enemies) {
        if (bullet.rect.overlaps(enemy.rect)) {
          if (!bullet.isPiercing) {
            bullet.shouldRemove = true;
          }
          enemy.hp -= bullet.damage;
          if (enemy.hp <= 0) {
            enemy.shouldRemove = true;
            player.score += enemy.scoreValue;
            _tryDropItem(enemy, items);
            _spawnEnemyDeathEffect(particles, enemy);
          } else {
            enemy.lastHitTick = _ticks;
            _spawnExplosion(particles, bullet.position, Colors.white, 5);
          }
        }
      }
    }

    // Enemy Bullets/Bodies hit Player
    if (!player.hasShield) {
      for (final bullet in bullets.where((b) => !b.isPlayerBullet)) {
        if (bullet.rect.overlaps(player.rect)) {
          bullet.shouldRemove = true;
          player.hp -= bullet.damage;
          player.lastHitTick = _ticks;
          _spawnExplosion(particles, bullet.position, Colors.red, 5);
        }
      }
      for (final enemy in enemies) {
        if (enemy.rect.overlaps(player.rect)) {
          enemy.shouldRemove = true;
          player.hp -= 20; // Collision damage
          player.lastHitTick = _ticks;
          _spawnExplosion(particles, enemy.position, Colors.red, 10);
        }
      }
    }

    // Player collects Items
    for (final item in items) {
      if (item.rect.overlaps(player.rect)) {
        item.shouldRemove = true;
        _applyItemEffect(player, item);
      }
    }

    // 6. Cleanup
    enemies.removeWhere((e) => e.shouldRemove);
    bullets.removeWhere((b) => b.shouldRemove);
    items.removeWhere((i) => i.shouldRemove);
    particles.removeWhere((p) => p.shouldRemove);

    // 7. Check Game Over
    if (player.hp <= 0) {
      emit(state.copyWith(
        status: NeonShooterStatus.gameOver,
        player: player,
        enemies: enemies,
        bullets: bullets,
        items: items,
      ));
    } else {
      // Shield timer
      if (player.shieldTime > 0) {
        player.shieldTime -= 0.016; // 16ms
      }

      // Wave progression (simple: every 1000 score)
      int newWave = (player.score / 1000).floor() + 1;

      emit(state.copyWith(
        player: player,
        enemies: enemies,
        bullets: bullets,
        items: items,
        particles: particles,
        wave: newWave,
        ticks: _ticks,
      ));
    }
  }

  void _spawnEnemy(List<Enemy> enemies, Size screenSize, int wave) {
    if (screenSize.isEmpty) return;

    double x = _random.nextDouble() * (screenSize.width - 40);
    EnemyType type = EnemyType.normal;
    double hp = 20.0 + wave * 5;
    double speed = 2.0 + wave * 0.1;
    Color color = const Color(0xFFFF00FF); // Magenta
    int score = 10;

    int roll = _random.nextInt(100);
    if (roll < 5 && wave > 2) {
      type = EnemyType.boss;
      hp = 500.0 + wave * 50;
      speed = 1.0;
      color = const Color(0xFFFF0000); // Red
      score = 500;
      x = screenSize.width / 2 - 40; // Center
    } else if (roll < 20 && wave > 0) {
      type = EnemyType.shooter;
      hp = 30.0 + wave * 5;
      speed = 1.5;
      color = const Color(0xFFFFFF00); // Yellow
      score = 30;
    } else if (roll < 40) {
      type = EnemyType.fast;
      hp = 10.0 + wave * 2;
      speed = 4.0 + wave * 0.2;
      color = const Color(0xFF00FF00); // Green
      score = 20;
    } else if (roll < 60 && wave > 1) {
      type = EnemyType.sine;
      hp = 25.0 + wave * 3;
      speed = 2.0 + wave * 0.1;
      color = Colors.purpleAccent;
      score = 25;
    } else if (roll < 80 && wave > 2) {
      type = EnemyType.tracker;
      hp = 20.0 + wave * 3;
      speed = 2.5; // Speed handled in update
      color = Colors.orangeAccent;
      score = 30;
    }

    enemies.add(Enemy(
      position: Offset(x, -50),
      size: type == EnemyType.boss ? const Size(80, 80) : const Size(40, 40),
      velocity: Offset(0, speed),
      color: color,
      hp: hp,
      maxHp: hp,
      enemyType: type,
      scoreValue: score,
    ));
  }

  void _fireBullet(Player player, List<Bullet> bullets) {
    const double bulletDamage = 20.0;
    const Color bulletColor = Color(0xFF00FFFF);
    const Size bulletSize = Size(10, 20);

    switch (player.weaponType) {
      case WeaponType.single:
        bullets.add(Bullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -10),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        ));
        break;
      case WeaponType.doubleGun:
        bullets.add(Bullet(
          position: player.position + Offset(player.size.width / 4 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -10),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        ));
        bullets.add(Bullet(
          position:
              player.position + Offset(player.size.width * 3 / 4 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -10),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        ));
        break;
      case WeaponType.shotgun:
        bullets.add(Bullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -10),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        ));
        bullets.add(Bullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(-3, -9),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        ));
        bullets.add(Bullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(3, -9),
          color: bulletColor,
          damage: bulletDamage,
          isPlayerBullet: true,
        ));
        break;
      case WeaponType.piercing:
        bullets.add(Bullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -12),
          color: Colors.yellow,
          damage: bulletDamage,
          isPlayerBullet: true,
          isPiercing: true,
        ));
        break;
      case WeaponType.tracking:
        bullets.add(Bullet(
          position: player.position + Offset(player.size.width / 2 - 5, -10),
          size: bulletSize,
          velocity: const Offset(0, -8),
          color: Colors.greenAccent,
          damage: bulletDamage,
          isPlayerBullet: true,
          isTracking: true,
        ));
        break;
    }
  }

  void _enemyFire(Enemy enemy, List<Bullet> bullets, Player player) {
    Offset direction = (player.position - enemy.position);
    double distance = direction.distance;
    if (distance == 0) return;
    direction = direction / distance;

    bullets.add(Bullet(
      position:
          enemy.position + Offset(enemy.size.width / 2 - 5, enemy.size.height),
      size: const Size(10, 10),
      velocity: direction * 5,
      color: enemy.color,
      damage: 10,
      isPlayerBullet: false,
    ));
  }

  void _tryDropItem(Enemy enemy, List<Item> items) {
    if (_random.nextInt(100) < 15) {
      // 15% chance
      ItemType type;
      WeaponType? weaponType;
      Color color = Colors.white;

      int roll = _random.nextInt(100);
      if (roll < 70) {
        // 70% of drops are weapons
        type = ItemType.weapon;
        weaponType =
            WeaponType.values[_random.nextInt(WeaponType.values.length)];
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

      items.add(Item(
        position: enemy.position,
        size: const Size(20, 20),
        velocity: const Offset(0, 2),
        color: color,
        itemType: type,
        weaponType: weaponType,
      ));
    }
  }

  void _applyItemEffect(Player player, Item item) {
    switch (item.itemType) {
      case ItemType.weapon:
        if (item.weaponType != null) {
          player.weaponType = item.weaponType!;
        }
        break;
      case ItemType.shield:
        player.shieldTime = 10.0; // 10 seconds
        break;
      case ItemType.heal:
        player.hp = (player.hp + 30).clamp(0, player.maxHp);
        break;
    }
  }

  void _spawnExplosion(
      List<Particle> particles, Offset position, Color color, int count) {
    for (int i = 0; i < count; i++) {
      double angle = _random.nextDouble() * 2 * pi;
      double speed = 1.0 + _random.nextDouble() * 3.0;
      particles.add(Particle(
        position: position,
        size: const Size(2, 2),
        velocity: Offset(cos(angle) * speed, sin(angle) * speed),
        color: color,
        life: 1.0,
        decay: 0.05 + _random.nextDouble() * 0.05,
      ));
    }
  }

  void _spawnEnemyDeathEffect(List<Particle> particles, Enemy enemy) {
    final center = enemy.rect.center;
    final color = enemy.color;

    // Outer ring shockwave
    const ringParticleCount = 20;
    for (int i = 0; i < ringParticleCount; i++) {
      final angle = (i / ringParticleCount) * 2 * pi;
      final speed = 3.0 + _random.nextDouble() * 2.0;
      particles.add(Particle(
        position: center,
        size: const Size(3, 3),
        velocity: Offset(cos(angle) * speed, sin(angle) * speed),
        color: color,
        life: 0.6,
        decay: 0.03,
      ));
    }

    // Inner core explosion
    const coreParticleCount = 30;
    for (int i = 0; i < coreParticleCount; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = _random.nextDouble() * 3.0; // Slower particles
      particles.add(Particle(
        position: center,
        size: const Size(2, 2),
        velocity: Offset(cos(angle) * speed, sin(angle) * speed),
        color: Colors.white,
        life: 1.2,
        decay: 0.04 + _random.nextDouble() * 0.04,
      ));
    }
  }
}

extension on Offset {
  Offset normalized() {
    final d = distance;
    if (d == 0) return Offset.zero;
    return this / d;
  }
}
