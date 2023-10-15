part of 'setting_bloc.dart';

class SettingState {
  final bool isShowLoading;

  SettingState({
    this.isShowLoading = false,
  });

  SettingState copyWith({
    bool? isShowLoading,
  }) {
    return SettingState(
      isShowLoading: isShowLoading ?? this.isShowLoading,
    );
  }
}
