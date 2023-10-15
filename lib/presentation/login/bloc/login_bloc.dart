import 'package:bloc/bloc.dart';
import 'package:flutter_resume/presentation/app/app.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppCubit _appCubit;

  LoginBloc(
    this._appCubit,
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
    final result = await _appCubit.login(
      account: account,
      password: password,
    );
    emit(state.copyWith(isShowLoading: false));
    if (!result) {
      // todo
      return;
    }
    emit(state.copyWith(isLoginSuccess: true));
  }
}
