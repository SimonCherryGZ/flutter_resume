import 'package:bloc/bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
