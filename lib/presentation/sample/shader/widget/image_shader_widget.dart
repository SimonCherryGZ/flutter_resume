import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/shader/entity/entity.dart';
import 'shader_widget.dart';

class ImageShaderWidget extends StatelessWidget {
  const ImageShaderWidget({
    super.key,
    required this.image,
    required this.filter,
    this.fit = BoxFit.contain,
    this.loadingBuilder,
  });

  final ui.Image image;
  final AbsFilter filter;
  final BoxFit fit;
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutWidth = constraints.maxWidth;
        final layoutHeight = constraints.maxHeight;
        final layoutAspectRatio = layoutWidth / layoutHeight;

        final imageWidth = image.width.toDouble();
        final imageHeight = image.height.toDouble();
        final imageAspectRatio = imageWidth / imageHeight;

        final double contentWidth;
        final double contentHeight;
        switch (fit) {
          case BoxFit.contain:
            if (imageAspectRatio > layoutAspectRatio) {
              contentWidth = layoutWidth;
              contentHeight = layoutWidth / imageAspectRatio;
            } else {
              contentWidth = layoutHeight * imageAspectRatio;
              contentHeight = layoutHeight;
            }
            break;
          case BoxFit.cover:
            if (imageAspectRatio < layoutAspectRatio) {
              contentWidth = layoutWidth;
              contentHeight = layoutWidth / imageAspectRatio;
            } else {
              contentWidth = layoutHeight * imageAspectRatio;
              contentHeight = layoutHeight;
            }
            break;
          case BoxFit.fitWidth:
            contentWidth = layoutWidth;
            contentHeight = layoutWidth / imageAspectRatio;
            break;
          case BoxFit.fitHeight:
            contentWidth = layoutHeight * imageAspectRatio;
            contentHeight = layoutHeight;
            break;
          default:
            contentWidth = layoutWidth;
            contentHeight = layoutHeight;
        }
        return ShaderWidget(
          layoutSize: Size(layoutWidth, layoutHeight),
          contentSize: Size(contentWidth, contentHeight),
          filter: filter,
          loadingBuilder: loadingBuilder,
        );
      },
    );
  }
}
