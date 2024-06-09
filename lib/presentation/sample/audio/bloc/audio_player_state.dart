part of 'audio_player_bloc.dart';

class AudioPlayerState {
  final String? audioPath;
  final double? progress;
  final bool playing;

  AudioPlayerState({
    this.audioPath,
    this.progress,
    this.playing = false,
  });

  AudioPlayerState copyWith({
    String? audioPath,
    double? progress,
    bool? playing,
  }) {
    return AudioPlayerState(
      audioPath: audioPath ?? this.audioPath,
      progress: progress ?? this.progress,
      playing: playing ?? this.playing,
    );
  }
}
