import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(this._postRepository) : super(PostState()) {
    on<FetchComments>(_onFetchComments);
  }

  void _onFetchComments(FetchComments event, Emitter<PostState> emit) async {
    emit(state.copyWith(isFetching: true));
    final result = await _postRepository.fetchComments(feed: event.feed);
    emit(state.copyWith(isFetching: false, comments: result));
  }
}
