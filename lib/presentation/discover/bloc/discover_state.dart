part of 'discover_bloc.dart';

class DiscoverState {
  final List<Feed> feeds;
  final int page;

  DiscoverState({
    required this.feeds,
    required this.page,
  });

  DiscoverState.initial()
      : feeds = [],
        page = 1;

  DiscoverState copyWith({
    List<Feed>? feeds,
    int? page,
  }) {
    return DiscoverState(
      feeds: feeds ?? this.feeds,
      page: page ?? this.page,
    );
  }
}
