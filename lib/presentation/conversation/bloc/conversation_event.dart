part of 'conversation_bloc.dart';

abstract class ConversationEvent {}

class AddMessage extends ConversationEvent {
  final String text;

  AddMessage(this.text);
}

class UpdateMessages extends ConversationEvent {
  final List<Message> messages;

  UpdateMessages(this.messages);
}
