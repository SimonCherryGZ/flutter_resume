import 'package:flutter_resume/domain/domain.dart';

abstract class PostRepository {
  Future<List<Comment>> fetchComments({
    required Feed feed,
  });
}
