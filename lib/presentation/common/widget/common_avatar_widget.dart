import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonAvatarWidget extends StatelessWidget {
  const CommonAvatarWidget({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey.shade300,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: const Duration(milliseconds: 200),
        errorWidget: (context, url, error) {
          return Icon(
            Icons.mood_bad,
            size: size / 2,
          );
        },
      ),
    );
  }
}
