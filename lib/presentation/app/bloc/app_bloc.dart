import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final UserRepository _userRepository;

  AppCubit(this._userRepository) : super(AppState());

  Future<void> init() async {
    final user = await _userRepository.loadSignedUser();
    emit(state.copyWith(signedInUser: user));
  }

  Future<bool> login({
    required String account,
    required String password,
  }) async {
    final user = await _userRepository.login(
      account: account,
      password: password,
    );
    if (user != null) {
      await _userRepository.saveSignedUser(user);
    }
    emit(state.copyWith(signedInUser: user));
    return user != null;
  }

  Future<bool> logout() async {
    final result = await _userRepository.logout();
    if (result) {
      await _userRepository.clearSignedUser();
      emit(state.copyWith(signedInUser: null));
    }
    return result;
  }
}
