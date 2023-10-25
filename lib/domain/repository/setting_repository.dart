import 'package:flutter/material.dart';

abstract class SettingRepository {
  Future<Locale?> loadLocale();

  Future<void> saveLocale(Locale locale);

  Future<Color?> loadThemeColor();

  Future<void> saveThemeColor(Color themeColor);
}
