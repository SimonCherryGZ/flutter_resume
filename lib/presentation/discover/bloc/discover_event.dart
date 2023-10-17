part of 'discover_bloc.dart';

abstract class DiscoverEvent {}

class FetchData extends DiscoverEvent {
  final bool isRefresh;

  FetchData({
    this.isRefresh = false,
  });
}
