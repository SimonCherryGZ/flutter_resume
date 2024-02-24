import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CircleLayoutWidget extends MultiChildRenderObjectWidget {
  final double layoutSize;
  final double radiansOffset;

  const CircleLayoutWidget({
    required this.layoutSize,
    this.radiansOffset = 0,
    required List<Widget> children,
    Key? key,
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CircleLayoutRenderBox(
      layoutSize: layoutSize,
      radiansOffset: radiansOffset,
    );
  }
}

class CircleLayoutRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CircleLayoutData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CircleLayoutData> {
  final double layoutSize;
  final double radiansOffset;

  CircleLayoutRenderBox({
    required this.layoutSize,
    required this.radiansOffset,
  });

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! CircleLayoutData) {
      child.parentData = CircleLayoutData();
    }
  }

  @override
  void performLayout() {
    size = Size.square(layoutSize);

    final double radius = layoutSize / 2;

    int index = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      child.layout(constraints, parentUsesSize: true);

      double step = 360 / childCount;
      double radians = (2 * pi / 360) * step * index + radiansOffset;
      final x = sin(radians) * radius;
      final y = cos(radians) * radius;
      final double centerX = child.size.width / 2;
      final double centerY = child.size.height / 2;
      final CircleLayoutData parentData = child.parentData! as CircleLayoutData;
      parentData.offset = Offset(
        x - centerX + radius,
        radius - y - centerY,
      );

      child = parentData.nextSibling;
      index++;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}

class CircleLayoutData extends ContainerBoxParentData<RenderBox> {}
