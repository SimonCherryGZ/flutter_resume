import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/color_match.dart';

class ColorMatchTimeBloc
    extends Bloc<ColorMatchCommonEvent, ColorMatchCommonState> {
  static const int kDurationInMs = 30000;

  static ColorMatchTimeBloc of(BuildContext context) {
    return BlocProvider.of<ColorMatchTimeBloc>(context);
  }

  final _random = Random();
  Timer? _timer;

  ColorMatchTimeBloc()
      : super(ColorMatchCommonState(
          status: GameStatus.prepare,
          trueColor: ColorType.blue,
          showColor: ColorType.blue,
        )) {
    on<StartGame>(_onStartGame);
    on<NextColor>(_onNextColor);
    on<TimerTick>(_onTimeTick);
    on<SubmitAnswer>(_onSubmitColor);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _onStartGame(
    StartGame event,
    Emitter<ColorMatchCommonState> emit,
  ) {
    add(NextColor());

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

    emit(state.copyWith(status: GameStatus.playing, score: 0));
  }

  void _onNextColor(
    NextColor event,
    Emitter<ColorMatchCommonState> emit,
  ) {
    final trueColor = _randomColor;
    final showColor = _random.nextDouble() > 0.5 ? trueColor : _randomColor;
    emit(state.copyWith(
      trueColor: trueColor,
      showColor: showColor,
    ));
  }

  void _onTimeTick(
    TimerTick event,
    Emitter<ColorMatchCommonState> emit,
  ) {
    final tick = event.tick;
    final fps = (1 / 30.0 * 1000).floor();
    if (tick * fps >= kDurationInMs) {
      _timer?.cancel();
      emit(state.copyWith(status: GameStatus.end));
      return;
    }
    final percent = (tick * fps) % kDurationInMs / kDurationInMs * 100;
    emit(state.copyWith(percent: percent));
  }

  void _onSubmitColor(
    SubmitAnswer event,
    Emitter<ColorMatchCommonState> emit,
  ) {
    final submitTrue = event.submitTrue;
    final trueColor = state.trueColor;
    final showColor = state.showColor;
    final correct = (submitTrue && trueColor == showColor) ||
        (!submitTrue && trueColor != showColor);
    if (correct) {
      emit(state.copyWith(score: state.score + 1));
    } else {
      emit(state.copyWith(score: max(0, state.score - 1)));
    }
    add(NextColor());
  }

  ColorType get _randomColor {
    return ColorType.values[_random.nextInt(ColorType.values.length)];
  }
}

class StartGame extends ColorMatchCommonEvent {}

class SubmitAnswer extends ColorMatchCommonEvent {
  final bool submitTrue;

  SubmitAnswer(this.submitTrue);
}
