import 'package:flutter_resume/presentation/sample/color_match/entity/entity.dart';

class ColorMatchCommonState {
  final GameStatus status;
  final ColorType trueColor;
  final ColorType showColor;
  final double percent;
  final int score;

  ColorMatchCommonState({
    required this.status,
    required this.trueColor,
    required this.showColor,
    this.percent = 0,
    this.score = 0,
  });

  ColorMatchCommonState copyWith({
    GameStatus? status,
    ColorType? trueColor,
    ColorType? showColor,
    double? percent,
    int? score,
  }) {
    return ColorMatchCommonState(
      status: status ?? this.status,
      trueColor: trueColor ?? this.trueColor,
      showColor: showColor ?? this.showColor,
      percent: percent ?? this.percent,
      score: score ?? this.score,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorMatchCommonState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          trueColor == other.trueColor &&
          showColor == other.showColor &&
          percent == other.percent &&
          score == other.score;

  @override
  int get hashCode =>
      status.hashCode ^
      trueColor.hashCode ^
      showColor.hashCode ^
      percent.hashCode ^
      score.hashCode;
}
