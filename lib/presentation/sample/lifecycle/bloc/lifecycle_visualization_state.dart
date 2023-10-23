part of 'lifecycle_visualization_cubit.dart';

enum LifecycleVisualizationWidgetPosition {
  none,
  left,
  right,
}

class LifecycleVisualizationState {
  final LifecycleVisualizationWidgetPosition position;
  final Color color;
  final IconData iconData;

  LifecycleVisualizationState({
    this.position = LifecycleVisualizationWidgetPosition.none,
    this.color = Colors.purple,
    this.iconData = Icons.flutter_dash,
  });

  LifecycleVisualizationState copyWith({
    LifecycleVisualizationWidgetPosition? position,
    Color? color,
    IconData? iconData,
  }) {
    return LifecycleVisualizationState(
      position: position ?? this.position,
      color: color ?? this.color,
      iconData: iconData ?? this.iconData,
    );
  }
}
