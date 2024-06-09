part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent {}

class SwitchAudio extends AudioPlayerEvent {
  final String assetPath;

  SwitchAudio(this.assetPath);
}

class UpdateProgress extends AudioPlayerEvent {
  final double progress;

  UpdateProgress(this.progress);
}

class SeekToProgress extends AudioPlayerEvent {
  final double progress;

  SeekToProgress(this.progress);
}

class Play extends AudioPlayerEvent {}

class Pause extends AudioPlayerEvent {}

class Stop extends AudioPlayerEvent {}
