import 'package:bloc/bloc.dart';
import 'package:flutter_resume/domain/domain.dart';

part 'discover_event.dart';

part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final FeedRepository _feedRepository;

  DiscoverBloc(this._feedRepository) : super(DiscoverState.initial()) {
    on<FetchData>(_onFetchData);
  }

  void _onFetchData(FetchData event, Emitter<DiscoverState> emit) async {
    if (state.isFetching) {
      return;
    }
    emit(state.copyWith(isFetching: true));
    final isRefresh = event.isRefresh;
    final page = isRefresh ? 1 : state.page;
    final newFeeds = await _feedRepository.fetchData(
      page: page,
      count: 10,
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
