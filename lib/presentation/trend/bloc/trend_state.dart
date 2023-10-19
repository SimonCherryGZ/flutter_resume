part of 'trend_bloc.dart';

class TrendState {
  final List<Feed> feeds;
  final int page;
  final bool isFetching;

  TrendState({
    required this.feeds,
    required this.page,
    required this.isFetching,
  });

  TrendState.initial()
      : feeds = [],
        page = 1,
        isFetching = false;

  TrendState copyWith({
    List<Feed>? feeds,
    int? page,
    bool? isFetching,
  }) {
    return TrendState(
      feeds: feeds ?? this.feeds,
      page: page ?? this.page,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
