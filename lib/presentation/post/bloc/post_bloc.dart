import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(this._postRepository) : super(PostState()) {
    on<FetchComments>(_onFetchComments);
    on<ExpandReply>(_onExpandReply);
  }

  void _onFetchComments(FetchComments event, Emitter<PostState> emit) async {
    emit(state.copyWith(isFetching: true));
    final result = await _postRepository.fetchComments(feed: event.feed);
    emit(state.copyWith(isFetching: false, comments: result));
  }

  void _onExpandReply(ExpandReply event, Emitter<PostState> emit) {
    final comment = state.comments[event.index];
    int totalReplyCount = comment.replies.length;
    int showReplyCount = min(max(3, comment.showReplyCount), totalReplyCount);
    int remainReplyCount = max(0, totalReplyCount - showReplyCount);
    if (remainReplyCount > 0) {
      showReplyCount += 3;
      showReplyCount = min(totalReplyCount, showReplyCount);
      final newComment = comment.copyWith(showReplyCount: showReplyCount);
      final List<Comment> newComments = List.from(state.comments);
      newComments[event.index] = newComment;
      emit(state.copyWith(comments: newComments));
    }
  }
}
