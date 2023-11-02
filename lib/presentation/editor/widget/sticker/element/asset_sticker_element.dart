import 'package:flutter/material.dart';
import 'decoration_element.dart';

class AssetStickerElement extends DecorationElement {
  AssetStickerElement(
    this.imagePath, {
    required String id,
    required double originWidth,
    required double originHeight,
    required Rect editRect,
    required Offset offset,
  }) : super(
          id: id,
          originWidth: originWidth,
          originHeight: originHeight,
          editRect: editRect,
          offset: offset,
        );

  final String imagePath;

  @override
  Widget initWidget() {
    return Image.asset(
      imagePath,
      width: mOriginWidth,
      height: mOriginHeight,
      fit: BoxFit.cover,
    );
  }
}
