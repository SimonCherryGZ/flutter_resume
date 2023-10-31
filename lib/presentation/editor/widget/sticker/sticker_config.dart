import 'package:flutter/material.dart';

class StickerConfig {
  StickerConfig({
    required this.id,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.transform,
    this.isSelected = false,
  });

  final String id;
  final String imagePath;
  final double width;
  final double height;
  Matrix4 transform = Matrix4.identity();
  bool isSelected;

  bool isInRange(
    double x,
    double y,
    double iconSize, {
    VoidCallback? onTapTopLeft,
    VoidCallback? onTapTopRight,
    VoidCallback? onTapBottomLeft,
    VoidCallback? onTapBottomRight,
  }) {
    final translation = transform.getTranslation();
    final tx = translation.x - width / 2;
    final ty = translation.y - height / 2;
    if (isSelected) {
      if (isInTopLeftRange(x, y, iconSize)) {
        onTapTopLeft?.call();
        return true;
      }
      if (isInTopRightRange(x, y, iconSize)) {
        onTapTopRight?.call();
        return true;
      }
      if (isInBottomLeftRange(x, y, iconSize)) {
        onTapBottomLeft?.call();
        return true;
      }
      if (isInBottomRightRange(x, y, iconSize)) {
        onTapBottomRight?.call();
        return true;
      }
    }
    return x >= tx && x <= tx + width && y >= ty && y <= ty + height;
  }

  bool isInTopLeftRange(
    double x,
    double y,
    double iconSize,
  ) {
    final translation = transform.getTranslation();
    final tx = translation.x - width / 2 - iconSize / 2;
    final ty = translation.y - height / 2 - iconSize / 2;
    return x >= tx && x <= tx + iconSize && y >= ty && y <= ty + iconSize;
  }

  bool isInTopRightRange(
    double x,
    double y,
    double iconSize,
  ) {
    final translation = transform.getTranslation();
    final tx = translation.x + width / 2 - iconSize / 2;
    final ty = translation.y - height / 2 - iconSize / 2;
    return x >= tx && x <= tx + iconSize && y >= ty && y <= ty + iconSize;
  }

  bool isInBottomLeftRange(
    double x,
    double y,
    double iconSize,
  ) {
    final translation = transform.getTranslation();
    final tx = translation.x - width / 2 - iconSize / 2;
    final ty = translation.y + height / 2 - iconSize / 2;
    return x >= tx && x <= tx + iconSize && y >= ty && y <= ty + iconSize;
  }

  bool isInBottomRightRange(
    double x,
    double y,
    double iconSize,
  ) {
    final translation = transform.getTranslation();
    final tx = translation.x + width / 2 - iconSize / 2;
    final ty = translation.y + height / 2 - iconSize / 2;
    return x >= tx && x <= tx + iconSize && y >= ty && y <= ty + iconSize;
  }
}
