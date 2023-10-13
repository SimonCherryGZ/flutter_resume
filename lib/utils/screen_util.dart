// ignore_for_file: constant_identifier_names

import 'dart:math';
import 'package:flutter/widgets.dart';

class ScreenUtil {
  static const Size DESIGN_SIZE = Size(360, 640);

  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _screenDensity = 0.0;
  double _statusBarHeight = 0.0;
  double _topHeight = 0.0;
  double _bottomHeight = 0.0;
  double _leftWidth = 0.0;
  double _rightWidth = 0.0;

  static final ScreenUtil _instance = ScreenUtil();

  static ScreenUtil getInstance() {
    return _instance;
  }

  MediaQueryData? _mediaQueryData;

  Future init(BuildContext context) async {
    MediaQueryData mediaQuery = MediaQueryData.fromView(View.of(context));
    initFromMediaQueryData(mediaQuery);
  }

  Future initFromMediaQueryData(MediaQueryData mediaQuery) async {
    if (_mediaQueryData != mediaQuery) {
      _mediaQueryData = mediaQuery;
      _screenWidth = mediaQuery.size.width;
      _screenHeight = mediaQuery.size.height;
      _screenDensity = mediaQuery.devicePixelRatio;
      _statusBarHeight = mediaQuery.padding.top;
      _leftWidth = mediaQuery.padding.left;
      _rightWidth = mediaQuery.padding.right;

      EdgeInsets padding = mediaQuery.padding;
      // 显示键盘时，底部间距会变为 0，这里的逻辑避免了该问题导致的 UI 移动
      if (mediaQuery.padding.bottom == 0.0 &&
          mediaQuery.viewInsets.bottom != 0.0) {
        padding = padding.copyWith(bottom: mediaQuery.viewPadding.bottom);
      }
      _topHeight = padding.top;
      _bottomHeight = padding.bottom;

      debugPrint(' ---- 屏幕数值 ---- '
          '\n size: $_screenWidth x $screenHeight'
          '\n devicePixelRatio: $_screenDensity'
          '\n padding: $_leftWidth, $_topHeight, $_rightWidth, $_bottomHeight');
    }
  }

  /// 屏幕宽度
  double get screenWidth => _screenWidth;

  /// 屏幕高度
  double get screenHeight => _screenHeight;

  /// 屏幕像素密度
  double get screenDensity => _screenDensity;

  ///状态栏高度
  double get statusBarHeight => _statusBarHeight;

  ///顶部安全区高度
  double get topHeight => _topHeight;

  ///底部安全区高度
  double get bottomHeight => _bottomHeight;

  /// 左侧安全区宽度
  double get leftWidth => _leftWidth;

  /// 右侧安全区宽度
  double get rightWidth => _rightWidth;

  /// 当前屏幕宽度
  static double getScreenW(BuildContext? context) {
    if (context == null) {
      return getInstance()._screenWidth;
    }
    return MediaQuery.of(context).size.width;
  }

  /// 当前屏幕高度
  static double getScreenH(BuildContext? context) {
    if (context == null) {
      return getInstance()._screenHeight;
    }
    return MediaQuery.of(context).size.height;
  }

  /// 当前安全区高度
  static double getSafeAreaH(BuildContext? context) {
    return getScreenH(context) -
        getInstance().statusBarHeight -
        getInstance().bottomHeight;
  }

  /// 当前屏幕宽度
  static int getScreenPXW(BuildContext context) {
    return (MediaQuery.of(context).size.width *
            MediaQuery.of(context).devicePixelRatio)
        .toInt();
  }

  /// 当前屏幕高度
  static int getScreenPXH(BuildContext context) {
    return (MediaQuery.of(context).size.height *
            MediaQuery.of(context).devicePixelRatio)
        .toInt();
  }

  /// 当前屏幕像素密度
  static double getScreenDensity(BuildContext? context) {
    if (context == null) {
      return getInstance()._screenDensity;
    }
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double getScaleWidthSize(
    BuildContext? context,
    double size, {
    double? targetScaleWidth,
  }) {
    if (targetScaleWidth == null) {
      if (context == null) {
        targetScaleWidth = ScreenUtil._instance.screenWidth;
      }
      targetScaleWidth ??= ScreenUtil.getScreenW(context);
    }
    return getScaleSize(context, size,
        targetScaleSize: Size(targetScaleWidth, -1));
  }

  /// 按照设计图尺寸缩放 size，默认缩放值取宽高较小比例，避免内容超出屏幕
  static double getScaleSize(
    BuildContext? context,
    double size, {
    Size? targetScaleSize,
  }) {
    if (targetScaleSize == null) {
      double? getScreenW;
      double? getScreenH;
      if (context == null) {
        getScreenW = ScreenUtil._instance.screenWidth;
        getScreenH = ScreenUtil._instance.screenHeight;
      }
      getScreenW ??= ScreenUtil.getScreenW(context);
      getScreenH ??= ScreenUtil.getScreenH(context);
      targetScaleSize = Size(getScreenW, getScreenH);
    }
    double scaleSize = 1;
    if (targetScaleSize.width > 0 && targetScaleSize.height > 0) {
      scaleSize = min(targetScaleSize.width / DESIGN_SIZE.width,
          targetScaleSize.height / DESIGN_SIZE.height);
    } else if (targetScaleSize.width > 0) {
      scaleSize = targetScaleSize.width / DESIGN_SIZE.width;
    } else if (targetScaleSize.height > 0) {
      scaleSize = targetScaleSize.height / DESIGN_SIZE.height;
    }
    return size * scaleSize;
  }
}
