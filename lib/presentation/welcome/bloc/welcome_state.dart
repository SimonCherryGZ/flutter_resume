part of 'welcome_bloc.dart';

enum WelcomeAdStatus {
  initial,
  loaded,
  failed,
  closed,
}

class WelcomeState {
  final SplashAd? splashAd;
  final WelcomeAdStatus adStatus;

  WelcomeState({
    this.splashAd,
    this.adStatus = WelcomeAdStatus.initial,
  });

  WelcomeState.initial() : this();

  WelcomeState copyWith({
    SplashAd? splashAd,
    WelcomeAdStatus? adStatus,
  }) {
    return WelcomeState(
      splashAd: splashAd ?? this.splashAd,
      adStatus: adStatus ?? this.adStatus,
    );
  }
}
