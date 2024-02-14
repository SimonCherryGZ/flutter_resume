import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/color_match.dart';

class ColorMatchChoiceBloc
    extends Bloc<ColorMatchCommonEvent, ColorMatchCommonState> {
  static const int kLongestDurationInMs = 5000;
  static const int kShortestDurationInMs = 1500;

  static ColorMatchChoiceBloc of(BuildContext context) {
    return BlocProvider.of<ColorMatchChoiceBloc>(context);
  }

  final _random = Random();
  Timer? _timer;

  ColorMatchChoiceBloc()
      : super(ColorMatchCommonState(
          status: GameStatus.prepare,
          trueColor: ColorType.blue,
          showColor: ColorType.blue,
        )) {
    on<NextColor>(_onNextColor);
    on<TimerTick>(_onTimeTick);
    on<SubmitAnswer>(_onSubmitColor);
  }

  void _onNextColor(
    NextColor event,
    Emitter<ColorMatchCommonState> emit,
  ) {
    final trueColor = _randomColor;
    final showColor = _randomColor;

    _timer?.cancel();
    final fps = (1 / 30.0 * 1000).floor();
    _timer = Timer.periodic(
      Duration(milliseconds: fps),
      (timer) {
        if (isClosed) {
          return;
        }
        add(TimerTick(timer.tick));
      },
    );

    emit(state.copyWith(
      status: GameStatus.playing,
      score: event.restart ? 0 : state.score,
      trueColor: trueColor,
      showColor: showColor,
      percent: 0,
    ));
  }

  void _onTimeTick(
    TimerTick event,
    Emitter<ColorMatchCommonState> emit,
  ) {
    final tick = event.tick;
    final fps = (1 / 30.0 * 1000).floor();
    final duration =
        max(kShortestDurationInMs, kLongestDurationInMs - state.score * 50);
    if (tick * fps >= duration) {
      _timer?.cancel();
      emit(state.copyWith(status: GameStatus.end));
      return;
    }
    final percent = (tick * fps) % duration / duration * 100;
    emit(state.copyWith(percent: percent));
  }

  void _onSubmitColor(
    SubmitAnswer event,
    Emitter<ColorMatchCommonState> emit,
  ) {
    final submitColor = event.color;
    final trueColor = state.trueColor;
    final correct = (submitColor == trueColor);
    if (correct) {
      emit(state.copyWith(score: state.score + 1));
      add(NextColor(restart: false));
    } else {
      _timer?.cancel();
      emit(state.copyWith(status: GameStatus.end));
    }
  }

  ColorType get _randomColor {
    return ColorType.values[_random.nextInt(ColorType.values.length)];
  }
}

class SubmitAnswer extends ColorMatchCommonEvent {
  final ColorType color;

  SubmitAnswer(this.color);
}
