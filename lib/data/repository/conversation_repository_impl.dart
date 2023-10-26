import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/utils.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  ConversationRepositoryImpl() : _faker = Faker(1);

  final Faker _faker;

  @override
  Future<List<Conversation>?> fetchConversations(User currentUser) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
      _faker.nextInt(30) + 1,
      (index) => _faker.conversation(currentUser),
    );
  }
}
