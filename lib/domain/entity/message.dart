import 'package:flutter_resume/domain/domain.dart';

class Message {
  final String id;
  final User fromUser;
  final User toUser;
  final String content;
  final int timestamp;

  Message({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.content,
    required this.timestamp,
  });
}
