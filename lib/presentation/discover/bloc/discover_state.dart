part of 'discover_bloc.dart';

class DiscoverState {
  final List<Feed> feeds;
  final int page;
  final bool isFetching;

  DiscoverState({
    required this.feeds,
    required this.page,
    required this.isFetching,
  });

  DiscoverState.initial()
      : feeds = [],
        page = 1,
        isFetching = false;

  DiscoverState copyWith({
    List<Feed>? feeds,
    int? page,
    bool? isFetching,
  }) {
    return DiscoverState(
      feeds: feeds ?? this.feeds,
      page: page ?? this.page,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
