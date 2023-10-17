part of 'trend_bloc.dart';

abstract class TrendEvent {}

class FetchData extends TrendEvent {
  final bool isRefresh;

  FetchData({
    this.isRefresh = false,
  });
}
