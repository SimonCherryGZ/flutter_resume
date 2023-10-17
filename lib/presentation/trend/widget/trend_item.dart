import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/utils.dart';

class TrendItem extends StatelessWidget {
  final Feed feed;

  const TrendItem({
    required this.feed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width / 2 - 4.ss();
    final aspectRatio = feed.imageWidth * 1.0 / feed.imageHeight;
    final itemHeight = itemWidth / aspectRatio;
    return GestureDetector(
      onTap: () async {
        // todo
      },
      child: SizedBox(
        height: itemHeight + 80.ss(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: feed.imageUrl,
                fit: BoxFit.cover,
                memCacheWidth: (screenSize.width / 2).round(),
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
              ),
            ),
            Container(
              height: 40.ss(),
              padding:
                  EdgeInsets.symmetric(horizontal: 10.ss(), vertical: 5.ss()),
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
                  CircleAvatar(
                    radius: 10.ss(),
                    backgroundColor: Colors.grey,
                    child: CachedNetworkImage(
                      imageUrl: feed.author.avatar,
                      width: 20.ss(),
                      height: 20.ss(),
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 100),
                      fadeOutDuration: const Duration(milliseconds: 200),
                    ),
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
