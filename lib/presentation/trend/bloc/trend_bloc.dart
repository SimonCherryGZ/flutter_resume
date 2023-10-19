import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'trend_event.dart';

part 'trend_state.dart';

class TrendBloc extends Bloc<TrendEvent, TrendState> {
  final FeedRepository _feedRepository;

  TrendBloc(this._feedRepository) : super(TrendState.initial()) {
    on<FetchData>(_onFetchData);
  }

  void _onFetchData(FetchData event, Emitter<TrendState> emit) async {
    if (state.isFetching) {
      return;
    }
    emit(state.copyWith(isFetching: true));
    final isRefresh = event.isRefresh;
    final page = isRefresh ? 1 : state.page;
    final newFeeds = await _feedRepository.fetchData(
      page: page,
      count: 20,
    );
    emit(state.copyWith(isFetching: false));
    if (newFeeds == null) {
      // todo
      return;
    }
    if (newFeeds.isEmpty) {
      return;
    }
    final List<Feed> feeds =
        isRefresh ? newFeeds : (List.from(state.feeds)..addAll(newFeeds));
    emit(state.copyWith(
      feeds: feeds,
      page: page + 1,
    ));
  }
}
