import 'package:flutter_resume/domain/domain.dart';

class Comment {
  final User author;
  final String content;
  final List<Comment> replies;

  Comment({
    required this.author,
    required this.content,
    this.replies = const [],
  });
}
