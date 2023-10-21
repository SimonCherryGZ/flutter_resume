part of 'paging_load_bloc.dart';

class PagingLoadState<T> {
  final List<T> data;
  final int page;
  final bool isRefreshing;
  final bool isLoading;
  final bool isNoMoreData;

  PagingLoadState({
    required this.data,
    required this.page,
    required this.isRefreshing,
    required this.isLoading,
    required this.isNoMoreData,
  });

  PagingLoadState.initial()
      : data = [],
        page = 1,
        isRefreshing = false,
        isLoading = false,
        isNoMoreData = false;

  PagingLoadState<T> copyWith({
    List<T>? data,
    int? page,
    bool? isRefreshing,
    bool? isLoading,
    bool? isNoMoreData,
  }) {
    return PagingLoadState(
      data: data ?? this.data,
      page: page ?? this.page,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoading: isLoading ?? this.isLoading,
      isNoMoreData: isNoMoreData ?? this.isNoMoreData,
    );
  }

  bool get isFetching => isRefreshing || isLoading;
}
