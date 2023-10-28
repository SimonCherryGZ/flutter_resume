import 'dart:async';

import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  ConversationRepositoryImpl()
      : _faker = Faker(1),
        _conversationsStream = BehaviorSubject<List<Conversation>>();

  final Faker _faker;
  final List<Conversation> _conversations = [];
  final StreamController<List<Conversation>> _conversationsStream;

  @override
  Future<List<Conversation>?> fetchConversations(User currentUser) async {
    if (_conversations.isEmpty) {
      await Future.delayed(const Duration(seconds: 1));
      final data = List.generate(
        _faker.nextInt(30) + 1,
        (index) => _faker.conversation(currentUser),
      );
      _conversations.addAll(data);
      _conversationsStream.sink.add(_conversations);
    }
    return _conversations;
  }

  @override
  Stream<List<Conversation>> getConversationsStream(User currentUser) {
    return _conversationsStream.stream;
  }

  @override
  Future<void> addMessage({
    required String conversationId,
    required User fromUser,
    required User toUser,
    required String text,
  }) async {
    final message = Message(
      id: '${_faker.messageId}',
      fromUser: fromUser,
      toUser: toUser,
      content: text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    final length = _conversations.length;
    for (int i = 0; i < length; i++) {
      final c = _conversations[i];
      if (conversationId == c.id) {
        _conversations[i].messages.add(message);
        _conversationsStream.sink.add(List.from(_conversations));
        break;
      }
    }
  }
}
