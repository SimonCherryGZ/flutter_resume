import 'dart:async';

import 'package:just_audio/just_audio.dart';

class AudioManager {
  static AudioManager get instance => _instance;

  static final AudioManager _instance = AudioManager();

  static const String defaultBGMPlayerId = 'default_bgm_player';

  final Map<String, AudioPlayer> _playerMap = {};

  Future<void> setSource({
    required String path,
    required SourceType type,
    bool isLoop = false,
    String? playerId,
  }) async {
    final id = playerId ?? defaultBGMPlayerId;
    final player = _getPlayer(id, createIfNotExist: true);
    player?.setLoopMode(isLoop ? LoopMode.one : LoopMode.off);
    final AudioSource source;
    switch (type) {
      case SourceType.asset:
        source = AudioSource.asset(path);
        break;
      case SourceType.file:
        source = AudioSource.file(path);
        break;
      case SourceType.network:
        source = AudioSource.uri(Uri.parse(path));
    }
    await player?.setAudioSource(source);
  }

  Future<void> pause({
    String? playerId,
  }) async {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    await player?.pause();
  }

  Future<void> play({
    String? playerId,
  }) async {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    await player?.play();
  }

  Future<void> stop({
    String? playerId,
  }) async {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    await player?.stop();
  }

  Future<void> dispose({
    String? playerId,
  }) async {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    await player?.dispose();
    if (_playerMap.containsKey(playerId)) {
      _playerMap.remove(playerId);
    }
  }

  Future<void> disposeAll() async {
    for (final player in _playerMap.values) {
      await player.dispose();
    }
    _playerMap.clear();
  }

  Future<void> seek({
    String? playerId,
    Duration? position,
  }) async {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    await player?.seek(position);
  }

  Future<void> setVolume({
    String? playerId,
    double? volume,
  }) async {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    await player?.setVolume(volume ?? 1);
  }

  AudioSource? getSource({
    String? playerId,
  }) {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    return player?.audioSource;
  }

  PlayerState? getState({
    String? playerId,
  }) {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    return player?.playerState;
  }

  Duration? getDuration({
    String? playerId,
  }) {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    return player?.duration;
  }

  StreamSubscription<void>? setPlayerCompletedCallback({
    String? playerId,
    void Function()? callback,
  }) {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    return player?.playerStateStream.listen((playerState) {
      if (ProcessingState.completed == playerState.processingState) {
        callback?.call();
      }
    });
  }

  StreamSubscription<void>? setPlayerPositionChangedCallback({
    String? playerId,
    void Function(Duration duration)? callback,
  }) {
    final player = _getPlayer(playerId ?? defaultBGMPlayerId);
    return player?.positionStream.listen((duration) {
      callback?.call(duration);
    });
  }

  AudioPlayer? _getPlayer(
    String playerId, {
    bool createIfNotExist = false,
  }) {
    AudioPlayer? player = _playerMap[playerId];
    if (player == null && createIfNotExist) {
      player = AudioPlayer();
      _playerMap[playerId] = player;
    }
    return player;
  }
}

enum SourceType {
  asset,
  file,
  network,
}
