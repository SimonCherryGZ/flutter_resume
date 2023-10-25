import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final UserRepository _userRepository;
  final SettingRepository _settingRepository;

  AppCubit(this._userRepository, this._settingRepository) : super(AppState());

  Future<void> init() async {
    final user = await _userRepository.loadSignedUser();
    final color = await _settingRepository.loadThemeColor();
    final locale = await _settingRepository.loadLocale();
    emit(state.copyWith(
      signedInUser: user,
      themeColor: color != null
          ? Colors.primaries.where((e) => e.value == color.value).first
          : Colors.purple,
      locale: locale ?? const Locale('zh', 'CN'),
    ));
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
      emit(state.copyWithoutSignedInUser());
    }
    return result;
  }

  void updateThemeColor(MaterialColor themeColor) async {
    await _settingRepository.saveThemeColor(themeColor);
    emit(state.copyWith(themeColor: themeColor));
  }

  void updateLocale(Locale locale) async {
    await _settingRepository.saveLocale(locale);
    emit(state.copyWith(locale: locale));
  }
}
