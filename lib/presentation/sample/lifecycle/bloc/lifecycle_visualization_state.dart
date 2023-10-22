part of 'lifecycle_visualization_cubit.dart';

enum LifecycleVisualizationWidgetPosition {
  none,
  left,
  right,
}

class LifecycleVisualizationState {
  final LifecycleVisualizationWidgetPosition position;
  final Color color;

  LifecycleVisualizationState({
    this.position = LifecycleVisualizationWidgetPosition.none,
    this.color = Colors.purple,
  });

  LifecycleVisualizationState copyWith({
    LifecycleVisualizationWidgetPosition? position,
    Color? color,
  }) {
    return LifecycleVisualizationState(
      position: position ?? this.position,
      color: color ?? this.color,
    );
  }
}
