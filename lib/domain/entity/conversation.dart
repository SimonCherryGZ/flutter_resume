import 'package:flutter_resume/domain/domain.dart';

class Conversation {
  final String id;
  final String ownerId;
  final List<Message> messages;

  Conversation({
    required this.id,
    required this.ownerId,
    this.messages = const [],
  });
}
