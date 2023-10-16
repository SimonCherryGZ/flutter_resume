import 'package:flutter_resume/domain/domain.dart';

class Feed {
  final String title;
  final String imageUrl;
  final User author;

  Feed({
    required this.title,
    required this.imageUrl,
    required this.author,
  });
}
