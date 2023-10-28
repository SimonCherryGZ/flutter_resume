import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class DiscoverItem extends StatelessWidget {
  final Feed feed;

  const DiscoverItem({
    required this.feed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageWidth = screenSize.width;
    final aspectRatio = feed.imageWidth * 1.0 / feed.imageHeight;
    final imageHeight = imageWidth / aspectRatio;
    final itemHeight = min(imageHeight, imageWidth * 4 / 3);
    final heroTag = 'discover_${feed.id}';
    return GestureDetector(
      onTap: () {
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
        height: itemHeight + 150.ss(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 10.ss()),
                CommonAvatarWidget(
                  imageUrl: feed.author.avatar,
                  size: 30.ss(),
                ),
                SizedBox(width: 10.ss()),
                Text(
                  feed.author.nickname,
                  style: TextStyle(
                    fontSize: 12.ss(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.ss()),
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
            SizedBox(height: 15.ss()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.ss()),
              child: Text(
                feed.title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15.ss(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10.ss()),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.ss()),
                child: Text(
                  feed.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.ss(),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
