part of 'message_bloc.dart';

class MessageState {
  final List<Conversation> conversations;

  MessageState({
    this.conversations = const [],
  });

  MessageState copyWith({
    List<Conversation>? conversations,
  }) {
    return MessageState(
      conversations: conversations ?? this.conversations,
    );
  }
}
