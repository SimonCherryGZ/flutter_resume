import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

part 'animated_container_state.dart';

class AnimatedContainerCubit extends Cubit<AnimatedContainerState> {
  AnimatedContainerCubit() : super(AnimatedContainerState());

  final _random = Random();

  void randomize() {
    emit(state.copyWith(
      width: (_random.nextInt(90) + 10).ss(),
      height: (_random.nextInt(90) + 10).ss(),
      color: Colors.primaries[_random.nextInt(Colors.primaries.length)],
      shape: switch (state.shape) {
        BoxShape.circle => BoxShape.rectangle,
        BoxShape.rectangle => BoxShape.circle,
      },
      borderColor: Colors.primaries[_random.nextInt(Colors.primaries.length)],
      borderWidth: (_random.nextInt(4) + 1).ss(),
    ));
  }
}
