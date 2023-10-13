import 'package:flutter/material.dart';

import 'utils.dart';

extension DoubleExtension on double {
  double ss({
    BuildContext? context,
  }) {
    return ScreenUtil.getScaleSize(
      context,
      this,
    );
  }
}
