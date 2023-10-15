import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: SettingList(
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
                initSelection: '中文',
                onPerformAction: <String>(value) async {
                  // todo
                  if ('中文' == value) {
                    return SynchronousFuture('English' as String);
                  }
                  if ('English' == value) {
                    return SynchronousFuture('中文' as String);
                  }
                  return value;
                },
              ),
              SettingSelection(
                title: '主题色',
                initSelection: '紫色',
                onPerformAction: <String>(value) async {
                  // todo
                  if ('紫色' == value) {
                    return SynchronousFuture('青色' as String);
                  }
                  if ('青色' == value) {
                    return SynchronousFuture('紫色' as String);
                  }
                  return value;
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
              // todo
              showToast('TODO: 退出登录');
            },
          ),
        ],
      ),
    );
  }
}
