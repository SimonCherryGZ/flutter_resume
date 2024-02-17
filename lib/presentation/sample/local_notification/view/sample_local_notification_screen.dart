import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/config/notification_service.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:oktoast/oktoast.dart';

final _random = Random();

class SampleLocalNotificationScreen extends StatelessWidget {
  const SampleLocalNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notification'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showNotification();
          },
          child: const Text('Show Notification'),
        ),
      ),
    );
  }

  Future<void> _showNotification() async {
    final grantedNotificationPermission =
        await NotificationService().checkNotificationPermission();
    if (true != grantedNotificationPermission) {
      showToast('未授予通知权限');
      return;
    }
    const payloads = _SampleNotificationPayload.values;
    final payload = payloads[_random.nextInt(payloads.length)];
    NotificationService().showNotification(
      title: '通知测试',
      body: payload.desc,
      payload: payload.route,
    );
  }
}

enum _SampleNotificationPayload {
  setting(desc: '打开设置', route: AppRouter.setting),
  album(desc: '打开相册', route: AppRouter.album),
  sampleAsync(desc: '打开 Async 示例', route: AppRouter.sampleAsync),
  sampleShader(desc: '打开 Shader 示例', route: AppRouter.sampleShader);

  final String desc;
  final String route;

  const _SampleNotificationPayload({
    required this.desc,
    required this.route,
  });
}
