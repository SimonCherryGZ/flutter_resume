import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_resume/config/constants.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingView extends StatelessWidget {
  const SettingView({
    super.key,
    required this.currentLocale,
    required this.currentThemeColor,
  });

  final Locale currentLocale;
  final MaterialColor currentThemeColor;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingBloc>();
    final localeNames = LocaleNames.of(context)!;
    final l10n = L10nDelegate.l10n(context);
    return SettingList(
      sectionColor: Colors.white,
      sectionBorderRadius: 10.ss(),
      sectionMargin: EdgeInsets.symmetric(horizontal: 20.ss()),
      sectionPadding: EdgeInsets.symmetric(horizontal: 5.ss()),
      sectionTitleStyle: TextStyle(
        color: Colors.grey.shade600,
      ),
      sectionTitlePadding:
          EdgeInsets.fromLTRB(25.ss(), 30.ss(), 24.ss(), 10.ss()),
      tileHeight: 50.ss(),
      tilePadding: EdgeInsets.all(8.ss()),
      tileSuffixWidget: Padding(
        padding: EdgeInsets.all(8.ss()),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey.shade400,
          size: 15.ss(),
        ),
      ),
      tileSelectionStyle: const TextStyle(color: Colors.grey),
      settings: [
        SettingGroup(
          title: l10n.settingGroupTitleCommon,
          settings: [
            SettingSelection(
              title: l10n.settingOptionLanguage,
              initSelection: localeNames.nameOf(currentLocale.toString())!,
              onPerformAction: <String>(value) async {
                final result = await _showLocaleSelection(context);
                if (result == null) {
                  return value;
                }
                bloc.add(ChangeLocale(result));
                return SynchronousFuture(
                    localeNames.nameOf(result.toString()) as String);
              },
            ),
            SettingSelection(
              title: l10n.settingOptionThemeColor,
              initSelection: _getColorName(currentThemeColor, l10n),
              onPerformAction: <String>(value) async {
                final result = await _showThemeColorSelection(context, l10n);
                if (result == null) {
                  return value;
                }
                bloc.add(ChangeThemeColor(result));
                return SynchronousFuture(_getColorName(result, l10n) as String);
              },
            ),
          ],
        ),
        SettingGroup(
          title: l10n.settingGroupTitleAccount,
          settings: [
            SettingButton(
              title: l10n.settingOptionChangePassword,
              onTap: () {
                // todo
                showToast('TODO: 修改密码');
              },
            ),
            SettingButton(
              title: l10n.settingOptionDeleteAccount,
              onTap: () {
                // todo
                showToast('TODO: 注销账号');
              },
            ),
          ],
        ),
        SettingGroup(
          title: '测试占位',
          settings: [
            SettingSwitch(
              title: '测试占位1',
              initValue: false,
              onPerformAction: <bool>(value) async {
                // todo
                showToast('TODO: 测试1 - $value');
                return value;
              },
            ),
            SettingSwitch(
              title: '测试占位2',
              initValue: false,
              onPerformAction: <bool>(value) async {
                // todo
                showToast('TODO: 测试2 - $value');
                return value;
              },
            ),
          ],
        ),
      ],
      children: [
        SettingLogoutButton(
          onTap: () {
            bloc.add(Logout());
          },
        ),
      ],
    );
  }

  Future<Locale?> _showLocaleSelection(BuildContext context) async {
    final supportedLocales = L10nDelegate.supportedLocales;
    final localeNames = LocaleNames.of(context)!;
    return showDialog<Locale>(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView.separated(
            itemCount: supportedLocales.length,
            itemBuilder: (context, index) {
              final locale = supportedLocales[index];
              return ListTile(
                title: Text(localeNames.nameOf(locale.toString())!),
                onTap: () {
                  Navigator.of(context).pop(locale);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        );
      },
    );
  }

  Future<MaterialColor?> _showThemeColorSelection(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return showDialog<MaterialColor>(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView.separated(
            itemCount: themeColors.length,
            itemBuilder: (context, index) {
              final color = themeColors[index];
              return ListTile(
                title: Container(
                  color: color,
                  height: 40.ss(),
                  child: Center(
                    child: Text(
                      _getColorName(color, l10n),
                      style: const TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(color);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        );
      },
    );
  }

  String _getColorName(MaterialColor color, AppLocalizations l10n) {
    assert(themeColors.contains(color));
    switch (color) {
      case Colors.red:
        return l10n.colorRed;
      case Colors.orange:
        return l10n.colorOrange;
      case Colors.yellow:
        return l10n.colorYellow;
      case Colors.green:
        return l10n.colorGreen;
      case Colors.cyan:
        return l10n.colorCyan;
      case Colors.blue:
        return l10n.colorBlue;
      case Colors.purple:
        return l10n.colorPurple;
      default:
        return '';
    }
  }
}
