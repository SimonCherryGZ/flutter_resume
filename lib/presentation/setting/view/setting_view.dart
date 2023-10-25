import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

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
          title: '通用',
          settings: [
            SettingSelection(
              title: '语言',
              initSelection: currentLocale.toString(),
              onPerformAction: <String>(value) async {
                final result = await _showLocaleSelection(context);
                if (result == null) {
                  return value;
                }
                bloc.add(ChangeLocale(result));
                return SynchronousFuture(result.toString() as String);
              },
            ),
            SettingSelection(
              title: '主题色',
              initSelection: currentThemeColor.value.toString(),
              onPerformAction: <String>(value) async {
                final result = await _showThemeColorSelection(context);
                if (result == null) {
                  return value;
                }
                bloc.add(ChangeThemeColor(result));
                return SynchronousFuture(result.value.toString() as String);
              },
            ),
          ],
        ),
        SettingGroup(
          title: '账号',
          settings: [
            SettingButton(
              title: '修改密码',
              onTap: () {
                // todo
                showToast('TODO: 修改密码');
              },
            ),
            SettingButton(
              title: '注销账号',
              onTap: () {
                // todo
                showToast('TODO: 注销账号');
              },
            ),
          ],
        ),
        SettingGroup(
          title: '测试',
          settings: [
            SettingSwitch(
              title: '测试1',
              initValue: false,
              onPerformAction: <bool>(value) async {
                // todo
                showToast('TODO: 测试1 - $value');
                return value;
              },
            ),
            SettingSwitch(
              title: '测试2',
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
    return showDialog<Locale>(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView.separated(
            itemCount: supportedLocales.length,
            itemBuilder: (context, index) {
              final locale = supportedLocales[index];
              return ListTile(
                title: Text(locale.toString()),
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
  ) {
    return showDialog<MaterialColor>(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView.separated(
            itemCount: Colors.primaries.length,
            itemBuilder: (context, index) {
              final color = Colors.primaries[index];
              return ListTile(
                title: Text(color.value.toString()),
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
}
