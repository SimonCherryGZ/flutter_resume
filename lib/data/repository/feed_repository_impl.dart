import 'dart:math';

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
    if (_feeds.isEmpty) {
      for (int i = 0; i < _maxCount; i++) {
        int index = i + 1;
        final url = _faker.imageUrl();
        final start = url.lastIndexOf('_') + 1;
        final end = url.lastIndexOf('.');
        final substring = url.substring(start, end);
        final splits = substring.split('x');
        final width = int.parse(splits[0]);
        final height = int.parse(splits[1]);
        final feed = Feed(
          id: '$index',
          title: _faker.title(),
          imageUrl: url,
          imageWidth: width,
          imageHeight: height,
          author: _faker.user(),
          content: _faker.content(),
        );
        _feeds.add(feed);
      }
    }
    page = max(page, 1);
    count = max(count, 1);
    int start = (page - 1) * count;
    if (start >= _maxCount) {
      return [];
    }
    int end = min(start + count, _maxCount);
    return _feeds.sublist(start, end);
  }
}
