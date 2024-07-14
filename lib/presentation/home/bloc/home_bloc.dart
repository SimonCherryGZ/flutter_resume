import 'dart:async';

import 'package:bloc/bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<Init>(_onInit);
    on<DismissActionTips>(_onDismissActionTips);
  }

  FutureOr<void> _onInit(
    Init event,
    Emitter<HomeState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(showActionTips: true));
  }

  FutureOr<void> _onDismissActionTips(
    DismissActionTips event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(showActionTips: false));
  }
}
