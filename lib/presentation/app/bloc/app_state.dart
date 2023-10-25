part of 'app_bloc.dart';

class AppState {
  final User? signedInUser;
  final MaterialColor themeColor;
  final Locale locale;

  AppState({
    this.signedInUser,
    this.themeColor = Colors.purple,
    this.locale = const Locale('zh', 'CN'),
  });

  AppState copyWith({
    User? signedInUser,
    MaterialColor? themeColor,
    Locale? locale,
  }) {
    return AppState(
      signedInUser: signedInUser ?? this.signedInUser,
      themeColor: themeColor ?? this.themeColor,
      locale: locale ?? this.locale,
    );
  }

  AppState copyWithoutSignedInUser() {
    return AppState(
      signedInUser: null,
      themeColor: themeColor,
      locale: locale,
    );
  }

  bool get isSignedIn => signedInUser != null;
}
