part of 'app_bloc.dart';

class AppState {
  final User? currentUser;

  AppState({
    this.currentUser,
  });

  AppState copyWith({
    User? currentUser,
  }) {
    return AppState(
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
