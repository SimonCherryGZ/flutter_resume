part of 'welcome_bloc.dart';

enum WelcomeAdStatus {
  initial,
  loaded,
  failed,
  closed,
}

class WelcomeState {
  final ByteData? adImageBytes;
  final WelcomeAdStatus adStatus;

  WelcomeState({
    this.adImageBytes,
    this.adStatus = WelcomeAdStatus.initial,
  });

  WelcomeState.initial() : this();

  WelcomeState copyWith({
    ByteData? adImageBytes,
    WelcomeAdStatus? adStatus,
  }) {
    return WelcomeState(
      adImageBytes: adImageBytes ?? this.adImageBytes,
      adStatus: adStatus ?? this.adStatus,
    );
  }
}
