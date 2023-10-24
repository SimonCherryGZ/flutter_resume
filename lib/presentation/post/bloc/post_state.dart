part of 'post_bloc.dart';

class PostState {
  final bool isFetching;
  final List<Comment> comments;

  PostState({
    this.isFetching = false,
    this.comments = const [],
  });

  PostState copyWith({
    bool? isFetching,
    List<Comment>? comments,
  }) {
    return PostState(
      isFetching: isFetching ?? this.isFetching,
      comments: comments ?? this.comments,
    );
  }
}
