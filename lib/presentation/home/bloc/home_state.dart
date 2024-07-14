part of 'home_bloc.dart';

class HomeState {
  final bool showActionTips;

  HomeState({
    this.showActionTips = false,
  });

  HomeState copyWith({
    bool? showActionTips,
  }) {
    return HomeState(
      showActionTips: showActionTips ?? this.showActionTips,
    );
  }
}
