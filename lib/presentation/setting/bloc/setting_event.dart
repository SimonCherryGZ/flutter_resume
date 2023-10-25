part of 'setting_bloc.dart';

abstract class SettingEvent {}

class Logout extends SettingEvent {}

class ChangeThemeColor extends SettingEvent {
  final MaterialColor themeColor;

  ChangeThemeColor(this.themeColor);
}

class ChangeLocale extends SettingEvent {
  final Locale locale;

  ChangeLocale(this.locale);
}
