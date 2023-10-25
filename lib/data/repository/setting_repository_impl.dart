import 'dart:ui';

import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/utils.dart';

class SettingRepositoryImpl implements SettingRepository {
  @override
  Future<Locale?> loadLocale() async {
    final sp = await SpUtil.getInstance();
    List<String>? tags = sp.getStringList('locale');
    if (tags == null || tags.isEmpty) return null;
    String lc = tags[0];
    String? sc = tags.length > 1 ? (tags[1].isEmpty ? null : tags[1]) : null;
    return Locale.fromSubtags(languageCode: lc, scriptCode: sc);
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    final sp = await SpUtil.getInstance();
    await sp.putStringList(
        'locale', [locale.languageCode, locale.scriptCode ?? '']);
  }

  @override
  Future<Color?> loadThemeColor() async {
    final sp = await SpUtil.getInstance();
    String? themeColor = sp.getString('themeColor');
    if (themeColor == null) return null;
    return Color(int.parse(themeColor));
  }

  @override
  Future<void> saveThemeColor(Color themeColor) async {
    final sp = await SpUtil.getInstance();
    await sp.putString('themeColor', themeColor.value.toString());
  }
}
