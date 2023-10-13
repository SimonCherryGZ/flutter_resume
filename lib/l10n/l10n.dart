import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

// 使用说明:
// https://docs.flutter.dev/ui/accessibility-and-localization/internationalization
//
// 1. 配置 pubspec.yaml
// dependencies:
//   intl: ^0.18.0
// flutter:
//   generate: true
//
// 2. 配置 l10n.yaml, 示例如下
// arb-dir: lib/l10n/arb
// template-arb-file: app_en.arb
// output-localization-file: app_localizations.dart
// nullable-getter: false
//
// 3. 生成多语言
// 执行生成命令 flutter gen-l10n 或者 pub get 或者直接运行 (即执行 flutter run) 隐式生成
// 生成结果: .dart_tool/flutter_gen/gen_l10n
class L10nDelegate extends LocalizationsDelegate<AppLocalizations> {
  const L10nDelegate._();

  static const instance = L10nDelegate._();

  /// 设置默认语言和用户选择的语言
  static Locale? defaultLocale;

  /// App 支持的语言列表
  static List<Locale> get supportedLocales => [
        // 给用户的语言选项请使用 AppLocalizations.supportedLocales, 因为 L10nDelegate 增加了几个繁中地区
        ...AppLocalizations.supportedLocales,
        // 若只提供 app_zh_Hant.arb 需要添加繁中地区, 否则这些地区 load() 时在 supportedLocales 匹配到的是 Locale('zh')
        const Locale('zh', 'HK'),
        const Locale('zh', 'MO'),
        const Locale('zh', 'TW'),
      ];

  /// 用于图片本地化, 如: assets/images/l10n/$locale/win.png
  ///
  /// Localizations 会在 WidgetsApp 的 State build 方法构建, 且层级在 Navigator 之上
  // todo
  // static Locale get localeName => _lookupLocale(
  //     Localizations.localeOf(NamedRouter.navigatorKey.currentContext!));

  /// 用于字符串本地化
  ///
  /// 在 build 方法使用 final l10n = L10nDelegate.l10n(context);<br><br>
  /// 留意: <br>
  /// 应用内切换语言需要页面的 context 而不是 navigator context<br>
  /// 应用内切换语言对原生层不起效（如 iOS 的权限描述）, 需要自行维护原生层应用内 locale
  static AppLocalizations l10n(BuildContext ctx) => AppLocalizations.of(ctx);

  /// 繁体中文使用 app_zh_Hant.arb, 其它语言使用 app_xx.arb
  static Locale _lookupLocale(Locale locale) {
    if (locale.languageCode == 'zh') {
      // 简中: zh_CN, zh_SG, zh_CN_#Hans, zh_HK_#Hans, zh_MO_#Hans, zh_SG_#Hans
      // 繁中: zh_HK, zh_MO, zh_TW, zh_HK_#Hant, zh_TW_#Hant, zh_MO_#Hant
      // 英文: en, en_US, _US, en__POSIX, en_US_POSIX
      String name = Intl.canonicalizedLocale(locale.toString());
      if (locale.countryCode?.toUpperCase() == 'HK' ||
          locale.countryCode?.toUpperCase() == 'MO' ||
          locale.countryCode?.toUpperCase() == 'TW' ||
          locale.scriptCode?.toUpperCase() == 'HANT' ||
          name.toUpperCase().contains('HANT')) {
        return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant');
      }
    }
    return Locale.fromSubtags(languageCode: locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.delegate.load(_lookupLocale(locale));

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.delegate.isSupported(locale);

  @override
  bool shouldReload(L10nDelegate old) => false;
}

class AppLocale extends Cubit<Locale?> {
  static AppLocale of(BuildContext context) {
    return context.read<AppLocale>();
  }

  AppLocale(super.initialState);

  void update(Locale locale) {
    L10nDelegate.defaultLocale = locale;
    // todo
    // PreferencesUtil.setAppLocale(locale);
    emit(locale);
  }
}
