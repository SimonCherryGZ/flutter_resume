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
        final feed = Feed(
          title: _faker.title(),
          imageUrl: 'https://cdn.seovx.com/d//img/momcn-2D%20(${i + 1}).jpg',
          author: _faker.user(),
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
