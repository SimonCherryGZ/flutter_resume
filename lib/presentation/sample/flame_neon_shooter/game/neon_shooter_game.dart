import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';
import '../components/player_component.dart';
import '../components/enemy_component.dart';
import '../components/bullet_component.dart';
import '../components/item_component.dart';
import '../components/particle_component.dart';
import '../components/background_component.dart';
import '../systems/spawn_system.dart';
import '../systems/collision_system.dart';
import '../systems/weapon_system.dart';
import '../ui/hud_component.dart';
import '../audio/neon_audio_controller.dart';

enum NeonShooterGameStatus { initial, playing, gameOver }

class NeonShooterGame extends FlameGame with HasCollisionDetection {
  final Random _random = Random();
  int ticks = 0;

  NeonShooterGameStatus status = NeonShooterGameStatus.initial;
  PlayerComponent? player;
  final List<EnemyComponent> enemies = [];
  final List<BulletComponent> bullets = [];
  final List<ItemComponent> items = [];
  final List<ParticleComponent> particles = [];
  int wave = 1;

  late SpawnSystem spawnSystem;
  late CollisionSystem collisionSystem;
  late WeaponSystem weaponSystem;
  late NeonAudioController audioController;
  late HUDComponent hudComponent;
  late BackgroundComponent backgroundComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Initialize audio
    audioController = NeonAudioController();
    await audioController.init();

    // Add background
    backgroundComponent = BackgroundComponent(this);
    add(backgroundComponent);

    // Initialize systems
    spawnSystem = SpawnSystem(this);
    collisionSystem = CollisionSystem(this);
    weaponSystem = WeaponSystem(this);

    // Add HUD
    hudComponent = HUDComponent();
    add(hudComponent);

    // Start game
    restart();
  }

  void restart() {
    // Clear all entities
    for (final enemy in enemies) {
      enemy.removeFromParent();
    }
    for (final bullet in bullets) {
      bullet.removeFromParent();
    }
    for (final item in items) {
      item.removeFromParent();
    }
    for (final particle in particles) {
      particle.removeFromParent();
    }

    enemies.clear();
    bullets.clear();
    items.clear();
    particles.clear();

    // Reset game state
    ticks = 0;
    wave = 1;
    status = NeonShooterGameStatus.playing;

    // Create player
    if (player != null) {
      player!.removeFromParent();
    }

    // Calculate player position - use current size if available, otherwise use default
    final playerX = size.x > 0 ? size.x / 2 - 20 : 0.0;
    final playerY = size.y > 0 ? size.y - 100 : 0.0;

    final playerEntity = Player(
      position: Offset(playerX, playerY),
      size: const Size(40, 40),
      velocity: Offset.zero,
      color: const Color(0xFF00FFFF),
    );
    player = PlayerComponent(playerEntity, this);
    add(player!);

    // Start BGM
    audioController.playBgm();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // Update player position when size changes
    if (player != null && status == NeonShooterGameStatus.playing) {
      final playerX = size.x / 2 - 20;
      final playerY = size.y - 100;
      player!.entity.position = Offset(playerX, playerY);
      player!.position = Vector2(playerX, playerY);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (status != NeonShooterGameStatus.playing) return;

    ticks++;

    // Update background
    backgroundComponent.updateTicks(ticks);

    // Spawn enemies
    spawnSystem.update(ticks);

    // Player fire
    if (ticks % 15 == 0 && player != null) {
      weaponSystem.firePlayerBullet(player!.entity);
      audioController.playShoot();
    }

    // Enemy fire
    for (final enemy in enemies) {
      if (enemy.entity.enemyType == EnemyType.shooter ||
          enemy.entity.enemyType == EnemyType.boss) {
        if (_random.nextInt(100) < 2) {
          weaponSystem.fireEnemyBullet(enemy.entity, player?.entity);
        }
      }
    }

    // Collision detection
    collisionSystem.update(ticks);

    // Update player shield
    if (player != null && player!.entity.shieldTime > 0) {
      player!.entity.shieldTime -= dt;
    }

    // Update wave
    if (player != null) {
      wave = (player!.entity.score / 1000).floor() + 1;
    }

    // Check game over
    if (player != null && player!.entity.hp <= 0) {
      status = NeonShooterGameStatus.gameOver;
      audioController.stopBgm();
    }

    // Update HUD
    hudComponent.updateGameState(
      player?.entity.score ?? 0,
      player?.entity.hp ?? 0,
      player?.entity.maxHp ?? 100,
      wave,
      status == NeonShooterGameStatus.gameOver,
    );
  }

  void movePlayer(Offset delta) {
    if (status != NeonShooterGameStatus.playing || player == null) return;

    final entity = player!.entity;
    double newX = entity.position.dx + delta.dx;
    double newY = entity.position.dy + delta.dy;

    // Clamp to screen
    newX = newX.clamp(0.0, size.x - entity.size.width);
    newY = newY.clamp(0.0, size.y - entity.size.height);

    entity.position = Offset(newX, newY);
    player!.position = Vector2(newX, newY);
  }

  @override
  Future<void> onRemove() async {
    await audioController.dispose();
    super.onRemove();
  }
}
