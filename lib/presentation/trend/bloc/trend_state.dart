part of 'trend_bloc.dart';

class TrendState {
  final List<Feed> feeds;
  final int page;

  TrendState({
    required this.feeds,
    required this.page,
  });

  TrendState.initial()
      : feeds = [],
        page = 1;

  TrendState copyWith({
    List<Feed>? feeds,
    int? page,
  }) {
    return TrendState(
      feeds: feeds ?? this.feeds,
      page: page ?? this.page,
    );
  }
}
