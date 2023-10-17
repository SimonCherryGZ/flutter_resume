import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/utils.dart';

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
    return SizedBox(
      height: imageHeight + 150.ss(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 10.ss()),
              CircleAvatar(
                radius: 15.ss(),
                backgroundColor: Colors.grey,
                child: CachedNetworkImage(
                  imageUrl: feed.author.avatar,
                  width: 30.ss(),
                  height: 30.ss(),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 100),
                  fadeOutDuration: const Duration(milliseconds: 200),
                ),
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
          CachedNetworkImage(
            imageUrl: feed.imageUrl,
            fit: BoxFit.cover,
            memCacheWidth: imageWidth.toInt(),
            memCacheHeight: imageHeight.toInt(),
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
    );
  }
}
