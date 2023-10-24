import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/utils.dart';

class FeedRepositoryImpl implements FeedRepository {
  final Faker _faker;

  FeedRepositoryImpl() : _faker = Faker(1);

  static const int _maxCount = 100;

  final List<Feed> _feeds = [];

  @override
  Future<List<Feed>?> fetchData({
    required int page,
    required int count,
  }) async {
    page = max(page, 1);
    count = max(count, 1);
    int start = (page - 1) * count;
    if (start >= _maxCount) {
      return [];
    }
    int end = min(start + count, _maxCount);
    if (_feeds.length < end) {
      int count = end - _feeds.length;
      List<Future<Feed>> tasks = [];
      for (int i = 0; i < count; i++) {
        int index = start + i + 1;
        final imageUrl = 'https://cdn.seovx.com/d//img/momcn-2D%20($index).jpg';
        final task = _getFeed(
          index: index,
          title: _faker.title(),
          imageUrl: imageUrl,
          author: _faker.user(),
          content: _faker.content(),
        );
        tasks.add(task);
      }
      _feeds.addAll(await Future.wait(tasks));
    }
    return _feeds.sublist(start, end);
  }

  Future<Feed> _getFeed({
    required int index,
    required String title,
    required String imageUrl,
    required User author,
    required String content,
  }) {
    Completer<Feed> completer = Completer();
    Image image = Image(image: CachedNetworkImageProvider(imageUrl));
    image.image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
              final myImage = image.image;
              Size size =
                  Size(myImage.width.toDouble(), myImage.height.toDouble());
              final feed = Feed(
                id: '$index',
                title: title,
                imageUrl: imageUrl,
                imageWidth: size.width.toInt(),
                imageHeight: size.height.toInt(),
                author: author,
                content: content,
              );
              completer.complete(feed);
            },
            onError: (_, __) {
              final feed = Feed(
                id: '$index',
                title: title,
                imageUrl: imageUrl,
                imageWidth: 1,
                imageHeight: 1,
                author: author,
                content: content,
              );
              completer.complete(feed);
            },
          ),
        );
    return completer.future;
  }
}
