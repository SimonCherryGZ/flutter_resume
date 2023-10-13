import 'package:flutter/widgets.dart';

import 'utils.dart';

extension IntExtension on int {
  double ss({
    BuildContext? context,
  }) {
    return ScreenUtil.getScaleSize(
      context,
      toDouble(),
    );
  }
}
