import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/utils.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl() : _faker = Faker(1);

  final Faker _faker;

  final Map<String, List<Comment>> _commentCache = {};

  @override
  Future<List<Comment>> fetchComments({required Feed feed}) async {
    // 模拟请求评论
    await Future.delayed(const Duration(milliseconds: 500));
    var comments = _commentCache[feed.id];
    if (comments != null) {
      return comments;
    }
    comments = [];
    int count = _faker.nextInt(10);
    for (int i = 0; i < count; i++) {
      final comment = _faker.comment();
      comments.add(comment);
    }
    _commentCache[feed.id] = comments;
    return comments;
  }
}
