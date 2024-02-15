import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'abs_filter.dart';

class PixelationFilter extends AbsFilter {
  PixelationFilter({
    required this.image,
    required this.pixels,
  });

  final ui.Image image;
  double pixels;

  void updatePixels(double pixels) {
    this.pixels = pixels;
  }

  @override
  String get shaderAssetKey => 'assets/shaders/pixelation.frag';

  @override
  void draw(
    Canvas canvas,
    Size layoutSize,
    Size contentSize,
    ui.FragmentShader shader,
  ) {
    shader.setFloat(0, contentSize.width);
    shader.setFloat(1, contentSize.height);
    shader.setFloat(2, pixels);
    shader.setFloat(3, pixels);
    shader.setImageSampler(0, image);
    final px = (layoutSize.width - contentSize.width) / 2;
    final py = (layoutSize.height - contentSize.height) / 2;
    canvas.translate(px, py);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, contentSize.width, contentSize.height),
      Paint()..shader = shader,
    );
  }
}
