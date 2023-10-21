part of 'paging_load_bloc.dart';

abstract class PagingLoadEvent {}

class FetchData extends PagingLoadEvent {
  final bool isRefresh;

  FetchData({
    this.isRefresh = false,
  });
}
