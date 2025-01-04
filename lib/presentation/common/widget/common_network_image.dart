import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/utils/utils.dart';

class CommonNetworkImage extends StatelessWidget {
  const CommonNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.memCacheWidth,
    this.memCacheHeight,
    this.fit,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.placeholder,
    this.errorWidget,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final BoxFit? fit;
  final Duration fadeInDuration;
  final Duration? fadeOutDuration;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      fit: fit,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      placeholder: placeholder ??
          (context, url) {
            return Container(color: Colors.grey.shade300);
          },
      errorWidget: errorWidget ??
          (context, url, error) {
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
