import 'package:flutter_resume/domain/domain.dart';

abstract class ConversationRepository {
  Future<List<Conversation>?> fetchConversations(User currentUser);
}
