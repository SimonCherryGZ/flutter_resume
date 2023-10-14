import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepository _userRepository;

  AppBloc(this._userRepository) : super(AppState()) {
    on<InitSignedInUser>(_onInitSignedInUser);
    on<UpdateSignedInUser>(_onUpdateSignedInUser);
  }

  void _onInitSignedInUser(
      InitSignedInUser event, Emitter<AppState> emit) async {
    final user = await _userRepository.loadSignedUser();
    emit(state.copyWith(signedInUser: user));
  }

  void _onUpdateSignedInUser(
      UpdateSignedInUser event, Emitter<AppState> emit) async {
    final user = event.user;
    emit(state.copyWith(signedInUser: user));
  }
}
