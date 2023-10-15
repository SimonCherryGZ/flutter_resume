import 'package:bloc/bloc.dart';
import 'package:flutter_resume/presentation/app/app.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AppCubit _appCubit;

  SettingBloc(
    this._appCubit,
  ) : super(SettingState()) {
    on<Logout>(_onLogout);
  }

  void _onLogout(Logout event, Emitter<SettingState> emit) async {
    emit(state.copyWith(isShowLoading: true));
    final result = await _appCubit.logout();
    emit(state.copyWith(isShowLoading: false));
    if (!result) {
      // todo
      return;
    }
  }
}
