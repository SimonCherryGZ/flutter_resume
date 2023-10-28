import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class TrendItem extends StatelessWidget {
  const TrendItem({
    required this.feed,
    this.heroTagPrefix = 'trend',
    super.key,
  });

  final Feed feed;
  final String heroTagPrefix;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageWidth = screenSize.width / 2 - 4.ss();
    final aspectRatio = feed.imageWidth * 1.0 / feed.imageHeight;
    final imageHeight = imageWidth / aspectRatio;
    final itemHeight = min(imageHeight, imageWidth * 4 / 3);
    final heroTag = '${heroTagPrefix}_${feed.id}';
    return GestureDetector(
      onTap: () async {
        context.push(
          Uri(
            path: AppRouter.post,
            queryParameters: {
              'heroTag': heroTag,
            },
          ).toString(),
          extra: feed,
        );
      },
      child: SizedBox(
        height: itemHeight + 80.ss(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: imageWidth,
              height: itemHeight,
              child: Hero(
                tag: heroTag,
                child: CommonFeedImageWidget(
                  imageUrl: feed.imageUrl,
                  imageWidth: imageWidth.toInt(),
                  imageHeight: imageHeight.toInt(),
                ),
              ),
            ),
            Container(
              height: 40.ss(),
              padding: EdgeInsets.symmetric(
                horizontal: 10.ss(),
                vertical: 5.ss(),
              ),
              child: Text(
                feed.title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12.ss(),
                ),
              ),
            ),
            SizedBox(
              height: 35.ss(),
              child: Row(
                children: [
                  SizedBox(width: 5.ss()),
                  CommonAvatarWidget(
                    imageUrl: feed.author.avatar,
                    size: 20.ss(),
                  ),
                  SizedBox(width: 5.ss()),
                  Expanded(
                    child: Text(
                      feed.author.nickname,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 10.ss(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
