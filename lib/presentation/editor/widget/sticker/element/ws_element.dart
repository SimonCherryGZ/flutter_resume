// ignore_for_file: constant_identifier_names

import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../sticker.dart';

const double MIN_SCALE_FACTOR = 0.3; // 最小缩放倍数
const double MAX_SCALE_FACTOR = 4.0; // 最大缩放倍数

abstract class WsElement {
  final String mId;

  int mZIndex = -1; // 图像的层级

  double mMoveX = 0.0; // 初始化后相对 ElementContainerWidget 中心的移动距离

  double mMoveY = 0.0; // 初始化后相对 ElementContainerWidget 中心的移动距离

  final double mOriginWidth; // 初始化时内容的宽度

  final double mOriginHeight; // 初始化时内容的高度

  final Rect mEditRect; // 可绘制的区域

  double mRotate = 0.0; // 图像顺时针旋转的角度，以 pi 为基准

  double mScale = 1.0; // 图像缩放的大小

  double mAlpha = 1.0; // 图像的透明度

  bool mIsSelected = false; // 是否处于选中状态

  bool mIsSingeFingerMove = false; // 是否处于单指移动的状态

  bool mIsDoubleFingerScaleAndRotate = false; // 是否处于双指旋转缩放的状态

  final Offset mOffset; // ElementContainerWidget 相对屏幕的位移

  bool mIsFlip = false;

  WsElement({
    required this.mId,
    required this.mOriginWidth,
    required this.mOriginHeight,
    required this.mEditRect,
    required this.mOffset,
  });

  Widget initWidget();

  delete() {}

  update() {}

  Widget buildTransform() {
    Matrix4 matrix4 = Matrix4.translationValues(mMoveX, mMoveY, 0);
    matrix4.rotateZ(mRotate);
    matrix4.scale(mScale, mScale, 1);
    if (mIsFlip) {
      matrix4.rotateY(math.pi);
    }
    return Transform(
      alignment: Alignment.center,
      transform: matrix4,
      child: Opacity(
        opacity: mAlpha,
        child: initWidget(),
      ),
    );
  }

  select() {}

  unSelect() {}

  /// 当前 element 开始单指移动
  onSingleFingerMoveStart() {
    mIsSingeFingerMove = true;
  }

  /// 当前 element 单指移动中
  onSingleFingerMoveProcess(DragUpdateDetails d) {
    mMoveX += d.delta.dx;
    mMoveY += d.delta.dy;
  }

  /// 当前 element 单指移动结束
  onSingleFingerMoveEnd() {
    mIsSingeFingerMove = false;
  }

  double mBaseScale = 0;
  double mBaseRotate = 0;

  /// 开始双指旋转缩放
  onDoubleFingerScaleAndRotateStart(
      RotateScaleStartDetails rotateScaleStartDetails) {
    mIsDoubleFingerScaleAndRotate = true;
    mBaseScale = mScale;
    mBaseRotate = mRotate;
  }

  /// 双指旋转缩放中
  onDoubleFingerScaleAndRotateProcess(
      RotateScaleUpdateDetails rotateScaleUpdateDetails) {
    mScale = mBaseScale * rotateScaleUpdateDetails.scale;
    mScale = (mScale < MIN_SCALE_FACTOR ? MIN_SCALE_FACTOR : mScale);
    mScale = (mScale > MAX_SCALE_FACTOR ? MAX_SCALE_FACTOR : mScale);
    mRotate = mBaseRotate + rotateScaleUpdateDetails.rotation;
    // todo 弄清为啥这里有问题
    // mRotate = (mRotate % math.pi);
  }

  /// 双指旋转缩放结束
  onDoubleFingerScaleAndRotateEnd(RotateScaleEndDetails rotateScaleEndDetails) {
    mIsDoubleFingerScaleAndRotate = false;
    mBaseScale = 0;
    mBaseRotate = 0;
  }

  bool isInWholeDecoration(double motionEventX, double motionEventY) {
    return isPointInTheRect(motionEventX, motionEventY, getWholeRect());
  }

  bool isPointInTheRect(double motionEventX, double motionEventY, Rect rect) {
    double centerX = getContentRect().center.dx;
    double centerY = getContentRect().center.dy;
    double originX = (motionEventX - centerX) * math.cos(-mRotate) -
        (motionEventY - centerY) * math.sin(-mRotate) +
        centerX;
    double originY = (motionEventX - centerX) * math.sin(-mRotate) +
        (motionEventY - centerY) * math.cos(-mRotate) +
        centerY;
    return rect.contains(Offset(originX, originY));
  }

  Rect getWholeRect() {
    return getContentRect();
  }

  Rect getOriginWholeRect() {
    return getOriginContentRect();
  }

  Rect getContentRect() {
    double widgetCenterX = mEditRect.center.dx;
    double widgetCenterY = mEditRect.center.dy;
    double contentWidth = mOriginWidth * mScale;
    double contentHeight = mOriginHeight * mScale;

    Rect contentRect = Rect.fromLTRB(
        widgetCenterX + mMoveX - (contentWidth / 2),
        widgetCenterY + mMoveY - (contentHeight / 2),
        widgetCenterX + mMoveX + (contentWidth / 2),
        widgetCenterY + mMoveY + (contentHeight / 2));
    return contentRect;
  }

  Rect getOriginContentRect() {
    double viewCenterX = mEditRect.center.dx;
    double viewCenterY = mEditRect.center.dy;
    double contentWidth = mOriginWidth;
    double contentHeight = mOriginHeight;
    Rect originContentRect = Rect.fromLTRB(
        viewCenterX + mMoveX - (contentWidth / 2),
        viewCenterY + mMoveY - (contentHeight / 2),
        viewCenterX + mMoveX + (contentWidth / 2),
        viewCenterY + mMoveY + (contentHeight / 2));
    return originContentRect;
  }

  double getRelativeX(double screenX) {
    return screenX - mOffset.dx;
  }

  double getRelativeY(double screenY) {
    return screenY - mOffset.dy;
  }
}

bool isSameElement(WsElement? wsElementOne, WsElement? wsElementTwo) {
  if (wsElementOne == null || wsElementTwo == null) {
    return false;
  } else {
    return identical(wsElementOne, wsElementTwo);
  }
}
