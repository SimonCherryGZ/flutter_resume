import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/color_match.dart';

class ColorMatchRaceBloc
    extends Bloc<ColorMatchCommonEvent, ColorMatchRaceState> {
  static const int kLongestDurationInMs = 5000;
  static const int kShortestDurationInMs = 1500;

  static ColorMatchRaceBloc of(BuildContext context) {
    return BlocProvider.of<ColorMatchRaceBloc>(context);
  }

  final _random = Random();
  Timer? _timer;

  ColorMatchRaceBloc()
      : super(ColorMatchRaceState(
          status: GameStatus.prepare,
          trueColor: ColorType.blue,
          showColor: ColorType.blue,
          showColorList: [],
        )) {
    on<NextColor>(_onNextColor);
    on<TimerTick>(_onTimeTick);
    on<SubmitAnswer>(_onSubmitColor);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _onNextColor(NextColor event, Emitter<ColorMatchRaceState> emit) {
    // 备选答案
    final List<Pair<ColorType, ColorType>> showColorList = [];
    for (int i = 0; i < 3; i++) {
      final textColor = _randomColor;
      ColorType showColor;
      do {
        showColor = _randomColor;
      } while (showColor == textColor);
      showColorList.add(Pair(textColor, showColor));
    }
    // 正确答案
    final trueColor = _randomColor;
    int insertIndex = _random.nextInt(4);
    showColorList.insert(insertIndex, Pair(trueColor, trueColor));

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
      showColorList: showColorList,
      percent: 0,
    ));
  }

  void _onTimeTick(TimerTick event, Emitter<ColorMatchRaceState> emit) {
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

  void _onSubmitColor(SubmitAnswer event, Emitter<ColorMatchRaceState> emit) {
    final submitColor = event.submitColor;
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

class ColorMatchRaceState extends ColorMatchCommonState {
  final List<Pair<ColorType, ColorType>> showColorList;

  ColorMatchRaceState({
    required super.status,
    required super.trueColor,
    required super.showColor,
    required this.showColorList,
    super.percent = 0,
    super.score = 0,
  });

  @override
  ColorMatchRaceState copyWith({
    GameStatus? status,
    ColorType? trueColor,
    ColorType? showColor,
    List<Pair<ColorType, ColorType>>? showColorList,
    double? percent,
    int? score,
  }) {
    return ColorMatchRaceState(
      status: status ?? this.status,
      trueColor: trueColor ?? this.trueColor,
      showColor: showColor ?? this.showColor,
      showColorList: showColorList ?? this.showColorList,
      percent: percent ?? this.percent,
      score: score ?? this.score,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ColorMatchRaceState &&
          runtimeType == other.runtimeType &&
          showColorList == other.showColorList;

  @override
  int get hashCode => super.hashCode ^ showColorList.hashCode;
}

class SubmitAnswer extends ColorMatchCommonEvent {
  final ColorType submitColor;

  SubmitAnswer(this.submitColor);
}
