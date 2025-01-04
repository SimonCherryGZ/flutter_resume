import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/common/common.dart';

class CommonFeedImageWidget extends StatelessWidget {
  const CommonFeedImageWidget({
    super.key,
    required this.imageUrl,
    this.imageWidth,
    this.imageHeight,
  });

  final String imageUrl;
  final int? imageWidth;
  final int? imageHeight;

  @override
  Widget build(BuildContext context) {
    return CommonNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      memCacheWidth: imageWidth,
      memCacheHeight: imageHeight,
      fadeInDuration: const Duration(milliseconds: 100),
      fadeOutDuration: const Duration(milliseconds: 200),
    );
  }
}
