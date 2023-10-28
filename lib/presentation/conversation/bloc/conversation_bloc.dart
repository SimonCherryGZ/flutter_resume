import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(
    this._conversationId,
    this._currentUser,
    this._otherUser,
    this._conversationRepository,
  ) : super(ConversationState.initial()) {
    on<AddMessage>(_onAddMessage);
    on<UpdateMessages>(_onUpdateMessages);

    _conversationRepository
        .getConversationsStream(_currentUser)
        .listen((conversations) {
      for (final conversation in conversations) {
        if (_conversationId == conversation.id) {
          if (isClosed) {
            return;
          }
          add(UpdateMessages(conversation.messages));
          break;
        }
      }
    });
  }

  final String _conversationId;
  final User _currentUser;
  final User _otherUser;
  final ConversationRepository _conversationRepository;

  void _onAddMessage(AddMessage event, Emitter<ConversationState> emit) {
    _conversationRepository.addMessage(
      conversationId: _conversationId,
      fromUser: _currentUser,
      toUser: _otherUser,
      text: event.text,
    );
  }

  void _onUpdateMessages(
      UpdateMessages event, Emitter<ConversationState> emit) {
    emit(state.copyWith(
      messages: event.messages,
    ));
  }
}
