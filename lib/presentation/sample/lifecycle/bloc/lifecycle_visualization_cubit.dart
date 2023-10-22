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
}
