import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

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
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      memCacheWidth: imageWidth,
      memCacheHeight: imageHeight,
      fadeInDuration: const Duration(milliseconds: 100),
      fadeOutDuration: const Duration(milliseconds: 200),
      placeholder: (_, __) {
        return Container(color: Colors.grey.shade300);
      },
      errorWidget: (context, url, error) {
        return Center(
          child: Text(
            'Oops...图片加载不出来',
            style: TextStyle(
              fontSize: 12.ss(),
            ),
          ),
        );
      },
    );
  }
}
