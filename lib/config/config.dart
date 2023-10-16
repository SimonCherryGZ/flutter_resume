import 'dart:io';

import 'package:flutter/foundation.dart';

class BuildConfig {
  BuildConfig._();

  static bool isDevicePreviewEnabled =
      kDebugMode && (kIsWeb || !(Platform.isAndroid || Platform.isIOS));

  static bool isMouseDraggableForWebAndDesktop =
      kDebugMode || Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  // todo
  static String multiAvatarApiKey = '';
}
