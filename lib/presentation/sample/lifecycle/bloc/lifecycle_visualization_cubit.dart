import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'lifecycle_visualization_state.dart';

class LifecycleVisualizationCubit extends Cubit<LifecycleVisualizationState> {
  LifecycleVisualizationCubit() : super(LifecycleVisualizationState());

  setWidget() {
    emit(state.copyWith(
      position: LifecycleVisualizationWidgetPosition.left,
    ));
  }

  swapPosition() {
    final position = switch (state.position) {
      LifecycleVisualizationWidgetPosition.left =>
        LifecycleVisualizationWidgetPosition.right,
      LifecycleVisualizationWidgetPosition.right =>
        LifecycleVisualizationWidgetPosition.left,
      LifecycleVisualizationWidgetPosition.none =>
        LifecycleVisualizationWidgetPosition.none,
    };
    emit(state.copyWith(
      position: position,
    ));
  }

  removeWidget() {
    emit(state.copyWith(
      position: LifecycleVisualizationWidgetPosition.none,
    ));
  }

  updateColor(Color color) {
    emit(state.copyWith(
      color: color,
    ));
  }

  switchIconData() {
    emit(state.copyWith(
      iconData: switch (state.iconData) {
        Icons.flutter_dash => Icons.access_alarm,
        Icons.access_alarm => Icons.ac_unit,
        _ => Icons.flutter_dash,
      },
    ));
  }
}
