part of 'app_bloc.dart';

class AppState {
  final User? signedInUser;

  AppState({
    this.signedInUser,
  });

  AppState copyWith({
    User? signedInUser,
  }) {
    return AppState(
      signedInUser: signedInUser ?? this.signedInUser,
    );
  }

  bool get isSignedIn => signedInUser != null;
}
