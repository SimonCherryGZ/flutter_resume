part of 'animated_container_cubit.dart';

class AnimatedContainerState {
  final double width;
  final double height;
  final Color color;
  final BoxShape shape;
  final Color borderColor;
  final double borderWidth;

  AnimatedContainerState({
    this.width = 100,
    this.height = 100,
    this.color = Colors.cyanAccent,
    this.shape = BoxShape.rectangle,
    this.borderColor = Colors.black,
    this.borderWidth = 2,
  });

  AnimatedContainerState copyWith({
    double? width,
    double? height,
    Color? color,
    BoxShape? shape,
    Color? borderColor,
    double? borderWidth,
  }) {
    return AnimatedContainerState(
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
      shape: shape ?? this.shape,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }
}
