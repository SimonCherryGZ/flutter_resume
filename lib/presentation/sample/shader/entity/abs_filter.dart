import 'dart:ui' as ui;

import 'package:flutter/material.dart';

abstract class AbsFilter {
  String get shaderAssetKey;

  void draw(
    Canvas canvas,
    Size layoutSize,
    Size contentSize,
    ui.FragmentShader shader,
  );

  Future<ui.FragmentShader> loadShader() async {
    final program = await ui.FragmentProgram.fromAsset(shaderAssetKey);
    return program.fragmentShader();
  }
}
