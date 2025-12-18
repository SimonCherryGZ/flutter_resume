import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class NeonAudioController {
  // 创建自己的 Bgm 实例，而不是使用全局的 FlameAudio.bgm
  // 这样每次游戏创建时都会创建新实例，dispose 后可以重新创建
  late Bgm _bgm;

  // 使用 AudioPool 管理频繁播放的音效
  // shoot: 每15帧播放一次，非常频繁，需要支持重叠播放
  late AudioPool _shootPool;

  // hit: 可能同时多次命中
  late AudioPool _hitPool;

  // explosion: 可能同时多个爆炸
  late AudioPool _explosionPool;

  // item: 可能同时拾取多个物品
  late AudioPool _itemPool;

  Future<void> init() async {
    try {
      // 创建新的 Bgm 实例，使用全局的 AudioCache
      _bgm = Bgm(audioCache: FlameAudio.audioCache);
      // Initialize BGM subsystem
      await _bgm.initialize();

      // 初始化音效池
      // shoot: 最频繁，需要更多播放器实例
      _shootPool = await FlameAudio.createPool(
        'neon_shooter/shoot.mp3',
        minPlayers: 3,
        maxPlayers: 6,
      );

      // hit: 可能同时多次命中
      _hitPool = await FlameAudio.createPool(
        'neon_shooter/been_hit.mp3',
        minPlayers: 2,
        maxPlayers: 4,
      );

      // explosion: 可能同时多个爆炸
      _explosionPool = await FlameAudio.createPool(
        'neon_shooter/enemy_explosion.mp3',
        minPlayers: 2,
        maxPlayers: 4,
      );

      // item: 拾取物品，频率较低
      _itemPool = await FlameAudio.createPool(
        'neon_shooter/obtain_item.mp3',
        minPlayers: 1,
        maxPlayers: 3,
      );
    } catch (e) {
      debugPrint('Error initializing audio: $e');
    }
  }

  void playBgm() {
    try {
      _bgm.play('neon_shooter/bgm.mp3', volume: 1);
    } catch (e) {
      debugPrint('Error playing BGM: $e');
    }
  }

  void stopBgm() {
    try {
      _bgm.stop();
    } catch (e) {
      debugPrint('Error stopping BGM: $e');
    }
  }

  void playShoot() {
    try {
      _shootPool.start(volume: 0.5);
    } catch (e) {
      debugPrint('Error playing shoot sound: $e');
    }
  }

  void playHit() {
    try {
      _hitPool.start(volume: 0.5);
    } catch (e) {
      debugPrint('Error playing hit sound: $e');
    }
  }

  void playExplosion() {
    try {
      _explosionPool.start(volume: 0.5);
    } catch (e) {
      debugPrint('Error playing explosion sound: $e');
    }
  }

  void playItem() {
    try {
      _itemPool.start(volume: 0.5);
    } catch (e) {
      debugPrint('Error playing item sound: $e');
    }
  }

  Future<void> dispose() async {
    stopBgm();
    try {
      // dispose 自己的 Bgm 实例，释放资源
      _bgm.dispose();

      // dispose 所有音效池
      await _shootPool.dispose();
      await _hitPool.dispose();
      await _explosionPool.dispose();
      await _itemPool.dispose();
    } catch (e) {
      debugPrint('Error disposing audio: $e');
    }
  }
}
