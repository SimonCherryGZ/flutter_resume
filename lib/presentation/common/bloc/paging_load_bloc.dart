import 'package:bloc/bloc.dart';

part 'paging_load_event.dart';

part 'paging_load_state.dart';

abstract class AbsPagingLoadBloc<T>
    extends Bloc<PagingLoadEvent, PagingLoadState<T>> {
  final int countPerPage;

  AbsPagingLoadBloc({
    required this.countPerPage,
  }) : super(PagingLoadState<T>.initial()) {
    on<FetchData>(_onFetchData);
  }

  Future<List<T>?> fetchData({
    required int page,
    required int count,
  });

  void _onFetchData(FetchData event, Emitter<PagingLoadState> emit) async {
    if (state.isFetching) {
      return;
    }
    final isRefresh = event.isRefresh;
    if (isRefresh) {
      emit(state.copyWith(
        isRefreshing: true,
        isNoMoreData: false,
      ));
    } else {
      emit(state.copyWith(
        isLoading: true,
      ));
    }
    final page = isRefresh ? 1 : state.page;
    final newData = await fetchData(
      page: page,
      count: countPerPage,
    );
    if (isRefresh) {
      emit(state.copyWith(
        isRefreshing: false,
      ));
    } else {
      bool noMore = newData == null || newData.length < countPerPage;
      emit(state.copyWith(
        isLoading: false,
        isNoMoreData: noMore,
      ));
    }
    if (newData == null) {
      // todo
      return;
    }
    if (newData.isEmpty) {
      return;
    }
    final List<T> data =
        isRefresh ? newData : (List.from(state.data)..addAll(newData));
    emit(state.copyWith(
      data: data,
      page: page + 1,
    ));
  }
}
