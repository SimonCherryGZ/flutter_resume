import 'package:bloc/bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<FocusPasswordField>(_onFocusPasswordField);
    on<UnFocusPasswordField>(_onUnFocusPasswordField);
    on<ShowPassword>(_onShowPassword);
    on<HidePassword>(_onHidePassword);
    on<UpdateAccount>(_onUpdateAccount);
    on<UpdatePassword>(_onUpdatePassword);
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
}
