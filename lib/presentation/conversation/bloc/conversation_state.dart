part of 'conversation_bloc.dart';

class ConversationState {
  final List<Message> messages;

  ConversationState({
    required this.messages,
  });

  ConversationState.initial() : messages = const [];

  ConversationState copyWith({
    List<Message>? messages,
  }) {
    return ConversationState(
      messages: messages ?? this.messages,
    );
  }
}
