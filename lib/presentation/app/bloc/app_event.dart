part of 'app_bloc.dart';

abstract class AppEvent {}

class InitSignedInUser extends AppEvent {}

class UpdateSignedInUser extends AppEvent {
  final User? user;

  UpdateSignedInUser(this.user);
}
