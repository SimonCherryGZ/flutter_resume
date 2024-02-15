import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class AssetImageShaderWidget extends StatelessWidget {
  const AssetImageShaderWidget({
    super.key,
    required this.assetImagePath,
    required this.filterBuilder,
    this.fit = BoxFit.contain,
    this.loadingBuilder,
  });

  final String assetImagePath;
  final AbsFilter Function(ui.Image image) filterBuilder;
  final BoxFit fit;
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(),
      builder: (context, snapshot) {
        final image = snapshot.data;
        if (image == null) {
          return Center(
            child: loadingBuilder?.call(context) ??
                const CircularProgressIndicator(),
          );
        }
        return ImageShaderWidget(
          image: image,
          fit: fit,
          filter: filterBuilder.call(image),
          loadingBuilder: loadingBuilder,
        );
      },
    );
  }

  Future<ui.Image> _loadImage() async {
    final ByteData assetImageByteData = await rootBundle.load(assetImagePath);
    final codec = await ui.instantiateImageCodec(
      assetImageByteData.buffer.asUint8List(),
    );
    return (await codec.getNextFrame()).image;
  }
}
