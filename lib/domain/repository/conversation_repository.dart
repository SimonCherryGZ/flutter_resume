import 'package:flutter_resume/domain/domain.dart';

abstract class ConversationRepository {
  Future<List<Conversation>?> fetchConversations(User currentUser);

  Stream<List<Conversation>> getConversationsStream(User currentUser);

  Future<void> addMessage({
    required String conversationId,
    required User fromUser,
    required User toUser,
    required String text,
  });
}
