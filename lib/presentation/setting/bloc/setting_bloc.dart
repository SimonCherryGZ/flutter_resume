import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/app/app.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AppCubit _appCubit;

  SettingBloc(
    this._appCubit,
  ) : super(SettingState()) {
    on<Logout>(_onLogout);
    on<ChangeThemeColor>(_onChangeThemeColor);
    on<ChangeLocale>(_onChangeLocale);
  }

  void _onLogout(Logout event, Emitter<SettingState> emit) async {
    emit(state.copyWith(isShowLoading: true));
    final result = await _appCubit.logout();
    emit(state.copyWith(isShowLoading: false));
    if (!result) {
      // todo
      return;
    }
  }

  void _onChangeThemeColor(ChangeThemeColor event, Emitter<SettingState> emit) {
    _appCubit.updateThemeColor(event.themeColor);
  }

  void _onChangeLocale(ChangeLocale event, Emitter<SettingState> emit) {
    _appCubit.updateLocale(event.locale);
  }
}
