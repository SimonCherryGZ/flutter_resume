import 'package:flutter/services.dart';

class Palette {
  static const MethodChannel _channel =
      MethodChannel('com.simoncherry.plugins/palette');

  static Future<List?> getImagePrimaryColors(
    Uint8List imageBytes, {
    int sampleSize = 256,
  }) async {
    return await _channel.invokeMethod(
      'getImagePrimaryColors',
      {
        'imageBytes': imageBytes,
        'sampleSize': sampleSize,
      },
    );
  }
}
