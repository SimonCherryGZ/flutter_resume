part of 'post_bloc.dart';

abstract class PostEvent {}

class FetchComments extends PostEvent {
  final Feed feed;

  FetchComments(this.feed);
}

class ExpandReply extends PostEvent {
  final int index;

  ExpandReply(this.index);
}
