import 'package:bloc/bloc.dart';
import 'package:flutter_resume/app/app.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final AppBloc _appBloc;

  LoginBloc(
    this._userRepository,
    this._appBloc,
  ) : super(LoginState.initial()) {
    on<FocusPasswordField>(_onFocusPasswordField);
    on<UnFocusPasswordField>(_onUnFocusPasswordField);
    on<ShowPassword>(_onShowPassword);
    on<HidePassword>(_onHidePassword);
    on<UpdateAccount>(_onUpdateAccount);
    on<UpdatePassword>(_onUpdatePassword);
    on<Login>(_onLogin);
  }

  void _onFocusPasswordField(
      FocusPasswordField event, Emitter<LoginState> emit) {
    emit(state.copyWith(isFocusPassword: true));
  }

  void _onUnFocusPasswordField(
      UnFocusPasswordField event, Emitter<LoginState> emit) {
    emit(state.copyWith(isFocusPassword: false));
  }

  void _onShowPassword(ShowPassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(isShowPassword: true));
  }

  void _onHidePassword(HidePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(isShowPassword: false));
  }

  void _onUpdateAccount(UpdateAccount event, Emitter<LoginState> emit) {
    emit(state.copyWith(account: event.account));
  }

  void _onUpdatePassword(UpdatePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    final account = state.account;
    final password = state.password;
    if (account == null || password == null) {
      // todo
      return;
    }
    emit(state.copyWith(isShowLoading: true));
    final user = await _userRepository.login(
      account: account,
      password: password,
    );
    emit(state.copyWith(isShowLoading: false));
    if (user == null) {
      // todo
      return;
    }
    _appBloc.add(UpdateCurrentUser(user));
    emit(state.copyWith(isLoginSuccess: true));
  }
}
