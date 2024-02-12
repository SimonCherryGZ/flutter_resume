import 'package:flutter/services.dart';

class ScreenSecurity {
  static const MethodChannel _channel =
      MethodChannel('com.simoncherry.plugins/screen_security');

  static void enable() {
    _channel.invokeMethod('enable');
  }

  static void disable() {
    _channel.invokeMethod('disable');
  }
}
