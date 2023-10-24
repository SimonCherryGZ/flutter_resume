import 'package:flutter_resume/domain/domain.dart';

class Feed {
  final String id;
  final String title;
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;
  final User author;
  final String content;

  Feed({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.author,
    required this.content,
  });

  Feed copyWith({
    String? id,
    String? title,
    String? imageUrl,
    int? imageWidth,
    int? imageHeight,
    User? author,
    String? content,
  }) {
    return Feed(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
      author: author ?? this.author,
      content: content ?? this.content,
    );
  }
}
