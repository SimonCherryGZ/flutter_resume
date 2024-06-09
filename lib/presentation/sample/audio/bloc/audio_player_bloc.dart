import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_resume/utils/utils.dart';

part 'audio_player_event.dart';

part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc() : super(AudioPlayerState()) {
    on<SwitchAudio>(_onSwitchAudio);
    on<UpdateProgress>(_onUpdateProgress);
    on<SeekToProgress>(_onSeekToProgress);
    on<Play>(_onPlay);
    on<Pause>(_onPause);
    on<Stop>(_onStop);
  }

  @override
  Future<void> close() {
    _positionChangedSubscription?.cancel();
    _playCompletedSubscription?.cancel();
    AudioManager.instance.disposeAll();
    return super.close();
  }

  StreamSubscription? _positionChangedSubscription;
  StreamSubscription? _playCompletedSubscription;

  FutureOr<void> _onSwitchAudio(
    SwitchAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    _positionChangedSubscription?.cancel();
    _playCompletedSubscription?.cancel();

    final audioPath = event.assetPath;
    emit(state.copyWith(audioPath: audioPath));

    await AudioManager.instance.setSource(
      path: audioPath,
      type: SourceType.asset,
    );
    _positionChangedSubscription =
        AudioManager.instance.setPlayerPositionChangedCallback(
      callback: (duration) {
        final totalInMs = AudioManager.instance.getDuration()?.inMilliseconds;
        if (totalInMs == null) {
          return;
        }
        final temp = duration.inMilliseconds / totalInMs;
        final progress = max(0.0, min(temp, 1.0));
        add(UpdateProgress(progress));
      },
    );
    _playCompletedSubscription =
        AudioManager.instance.setPlayerCompletedCallback(
      callback: () {
        add(Stop());
      },
    );
    AudioManager.instance.play();
    emit(state.copyWith(playing: true));
  }

  FutureOr<void> _onUpdateProgress(
    UpdateProgress event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(state.copyWith(progress: event.progress));
  }

  FutureOr<void> _onSeekToProgress(
    SeekToProgress event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final totalInMs = AudioManager.instance.getDuration()?.inMilliseconds;
    if (totalInMs == null) {
      return;
    }
    final positionInMs = (totalInMs * event.progress).toInt();
    final duration = Duration(milliseconds: positionInMs);
    AudioManager.instance.seek(position: duration);
  }

  FutureOr<void> _onPlay(
    Play event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final source = AudioManager.instance.getSource();
    if (source == null) {
      return;
    }
    if (state.playing) {
      return;
    }
    AudioManager.instance.play();
    emit(state.copyWith(playing: true));
  }

  FutureOr<void> _onPause(
    Pause event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final source = AudioManager.instance.getSource();
    if (source == null) {
      return;
    }
    if (!state.playing) {
      return;
    }
    AudioManager.instance.pause();
    emit(state.copyWith(playing: false));
  }

  FutureOr<void> _onStop(
    Stop event,
    Emitter<AudioPlayerState> emit,
  ) async {
    AudioManager.instance.pause();
    AudioManager.instance.seek(position: const Duration(milliseconds: 0));
    emit(state.copyWith(playing: false));
  }
}
