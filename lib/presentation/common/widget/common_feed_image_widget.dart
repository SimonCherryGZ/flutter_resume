import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
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
    final l10n = L10nDelegate.l10n(context);
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
        return Container(
          color: Colors.grey.shade300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mood_bad,
                color: Colors.black45,
              ),
              SizedBox(height: 5.ss()),
              Center(
                child: Text(
                  l10n.imageLoadFailedHint,
                  style: TextStyle(
                    fontSize: 12.ss(),
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
