import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/app/app.dart';
import 'package:flutter_resume/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DevicePreview(
    enabled: BuildConfig.isDevicePreviewEnabled,
    builder: (_) => MyApp(),
  ));
}
