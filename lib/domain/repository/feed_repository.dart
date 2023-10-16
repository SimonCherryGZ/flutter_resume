import 'package:flutter_resume/domain/domain.dart';

abstract class FeedRepository {
  Future<List<Feed>?> fetchData({
    required int page,
    required int count,
  });
}
