import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class NeonAudioController {
  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _shootPlayer = AudioPlayer();
  final AudioPlayer _hitPlayer = AudioPlayer();
  final AudioPlayer _explosionPlayer = AudioPlayer();
  final AudioPlayer _itemPlayer = AudioPlayer();

  Future<void> init() async {
    try {
      await _bgmPlayer.setAsset('assets/audio/neon_shooter/bgm.mp3');
      await _bgmPlayer.setLoopMode(LoopMode.one);

      await _shootPlayer.setAsset('assets/audio/neon_shooter/shoot.mp3');
      await _hitPlayer.setAsset('assets/audio/neon_shooter/been_hit.mp3');
      await _explosionPlayer
          .setAsset('assets/audio/neon_shooter/enemy_explosion.mp3');
      await _itemPlayer.setAsset('assets/audio/neon_shooter/obtain_item.mp3');
    } catch (e) {
      debugPrint('Error loading audio assets: $e');
    }
  }

  void playBgm() {
    _bgmPlayer.play();
  }

  void stopBgm() {
    _bgmPlayer.stop();
  }

  void playShoot() {
    _playSound(_shootPlayer);
  }

  void playHit() {
    _playSound(_hitPlayer);
  }

  void playExplosion() {
    _playSound(_explosionPlayer);
  }

  void playItem() {
    _playSound(_itemPlayer);
  }

  void _playSound(AudioPlayer player) {
    if (player.processingState == ProcessingState.idle) return;
    player.seek(Duration.zero);
    player.play();
  }

  void dispose() {
    _bgmPlayer.dispose();
    _shootPlayer.dispose();
    _hitPlayer.dispose();
    _explosionPlayer.dispose();
    _itemPlayer.dispose();
  }
}
