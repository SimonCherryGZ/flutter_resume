import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<UpdateCurrentUser>(_onUpdateCurrentUser);
  }

  void _onUpdateCurrentUser(UpdateCurrentUser event, Emitter<AppState> emit) {
    emit(state.copyWith(currentUser: event.user));
  }
}
