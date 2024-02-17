import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_resume/config/notification_service.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/config/config.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();

  runApp(DevicePreview(
    enabled: BuildConfig.isDevicePreviewEnabled,
    builder: (_) => MyApp(),
  ));
}
