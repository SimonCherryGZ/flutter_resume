import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class NeonAudioController {
  // 创建自己的 Bgm 实例，而不是使用全局的 FlameAudio.bgm
  // 这样每次游戏创建时都会创建新实例，dispose 后可以重新创建
  late Bgm _bgm;

  Future<void> init() async {
    try {
      // 创建新的 Bgm 实例，使用全局的 AudioCache
      _bgm = Bgm(audioCache: FlameAudio.audioCache);
      // Initialize BGM subsystem
      await _bgm.initialize();
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
      FlameAudio.play('neon_shooter/shoot.mp3', volume: 0.5);
    } catch (e) {
      debugPrint('Error playing shoot sound: $e');
    }
  }

  void playHit() {
    try {
      FlameAudio.play('neon_shooter/been_hit.mp3', volume: 0.5);
    } catch (e) {
      debugPrint('Error playing hit sound: $e');
    }
  }

  void playExplosion() {
    try {
      FlameAudio.play('neon_shooter/enemy_explosion.mp3', volume: 0.5);
    } catch (e) {
      debugPrint('Error playing explosion sound: $e');
    }
  }

  void playItem() {
    try {
      FlameAudio.play('neon_shooter/obtain_item.mp3', volume: 0.5);
    } catch (e) {
      debugPrint('Error playing item sound: $e');
    }
  }

  void dispose() {
    stopBgm();
    try {
      // dispose 自己的 Bgm 实例，释放资源
      _bgm.dispose();
    } catch (e) {
      debugPrint('Error disposing BGM: $e');
    }
  }
}
