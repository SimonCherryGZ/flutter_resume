import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/app/app.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(
    this._appCubit,
    this._conversationRepository,
  ) : super(MessageState()) {
    on<FetchData>(_onFetchData);
  }

  final AppCubit _appCubit;
  final ConversationRepository _conversationRepository;

  void _onFetchData(FetchData event, Emitter<MessageState> emit) async {
    final currentUser = _appCubit.state.signedInUser;
    if (currentUser == null) {
      return;
    }
    final conversations =
        await _conversationRepository.fetchConversations(currentUser);
    emit(state.copyWith(
      conversations: conversations,
    ));
  }
}
