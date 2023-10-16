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
    final page = state.page;
    final feeds = await _feedRepository.fetchData(
      page: page,
      count: 20,
    );
    if (feeds == null) {
      // todo
      return;
    }
    if (feeds.isEmpty) {
      return;
    }
    emit(state.copyWith(
      feeds: List.from(state.feeds)..addAll(feeds),
      page: page + 1,
    ));
  }
}
