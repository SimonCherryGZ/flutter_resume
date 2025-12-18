import 'package:flutter/material.dart';
import '../../neon_shooter/model/game_entity.dart';
import '../game/neon_shooter_game.dart';
import 'spawn_system.dart';

class CollisionSystem {
  final NeonShooterGame game;
  final SpawnSystem spawnSystem;

  CollisionSystem(this.game) : spawnSystem = SpawnSystem(game);

  void update(int ticks) {
    if (game.player == null || game.status != NeonShooterGameStatus.playing) return;

    final player = game.player!.entity;

    // Player Bullets hit Enemies
    for (final bulletComponent in game.bullets.where((b) => b.entity.isPlayerBullet)) {
      for (final enemyComponent in game.enemies) {
        if (bulletComponent.entity.rect.overlaps(enemyComponent.entity.rect)) {
          final bullet = bulletComponent.entity;
          final enemy = enemyComponent.entity;

          if (!bullet.isPiercing) {
            bullet.shouldRemove = true;
          }
          enemy.hp -= bullet.damage;
          if (enemy.hp <= 0) {
            enemy.shouldRemove = true;
            player.score += enemy.scoreValue;
            spawnSystem.tryDropItem(enemy);
            spawnSystem.spawnEnemyDeathEffect(enemy);
            game.audioController.playExplosion();
          } else {
            enemyComponent.lastHitTick = ticks;
            spawnSystem.spawnExplosion(bullet.position, Colors.white, 5);
            game.audioController.playHit();
          }
        }
      }
    }

    // Enemy Bullets/Bodies hit Player
    if (!player.hasShield) {
      for (final bulletComponent in game.bullets.where((b) => !b.entity.isPlayerBullet)) {
        if (bulletComponent.entity.rect.overlaps(player.rect)) {
          bulletComponent.entity.shouldRemove = true;
          player.hp -= bulletComponent.entity.damage;
          if (game.player != null) {
            game.player!.lastHitTick = ticks;
          }
          spawnSystem.spawnExplosion(bulletComponent.entity.position, Colors.red, 5);
          game.audioController.playHit();
        }
      }
      for (final enemyComponent in game.enemies) {
        if (enemyComponent.entity.rect.overlaps(player.rect)) {
          enemyComponent.entity.shouldRemove = true;
          player.hp -= 20; // Collision damage
          if (game.player != null) {
            game.player!.lastHitTick = ticks;
          }
          spawnSystem.spawnExplosion(enemyComponent.entity.position, Colors.red, 10);
          game.audioController.playHit();
        }
      }
    }

    // Player collects Items
    for (final itemComponent in game.items) {
      if (itemComponent.entity.rect.overlaps(player.rect)) {
        itemComponent.entity.shouldRemove = true;
        _applyItemEffect(player, itemComponent.entity);
        game.audioController.playItem();
      }
    }

    // Cleanup
    _cleanupEntities();
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

  void _cleanupEntities() {
    // Remove enemies
    final enemiesToRemove = game.enemies.where((e) => e.entity.shouldRemove).toList();
    for (final enemy in enemiesToRemove) {
      enemy.removeFromParent();
      game.enemies.remove(enemy);
    }

    // Remove bullets
    final bulletsToRemove = game.bullets.where((b) => b.entity.shouldRemove).toList();
    for (final bullet in bulletsToRemove) {
      bullet.removeFromParent();
      game.bullets.remove(bullet);
    }

    // Remove items
    final itemsToRemove = game.items.where((i) => i.entity.shouldRemove).toList();
    for (final item in itemsToRemove) {
      item.removeFromParent();
      game.items.remove(item);
    }

    // Remove particles
    final particlesToRemove = game.particles.where((p) => p.entity.shouldRemove).toList();
    for (final particle in particlesToRemove) {
      particle.removeFromParent();
      game.particles.remove(particle);
    }
  }
}
