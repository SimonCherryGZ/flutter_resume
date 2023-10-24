import 'package:flutter_resume/domain/domain.dart';

class Comment {
  final User author;
  final String content;
  final List<Comment> replies;
  final int showReplyCount;

  Comment({
    required this.author,
    required this.content,
    this.replies = const [],
    this.showReplyCount = 0,
  });

  Comment copyWith({
    User? author,
    String? content,
    List<Comment>? replies,
    int? showReplyCount,
  }) {
    return Comment(
      author: author ?? this.author,
      content: content ?? this.content,
      replies: replies ?? this.replies,
      showReplyCount: showReplyCount ?? this.showReplyCount,
    );
  }
}
