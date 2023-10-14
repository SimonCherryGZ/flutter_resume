part of 'app_bloc.dart';

abstract class AppEvent {}

class UpdateCurrentUser extends AppEvent {
  final User? user;

  UpdateCurrentUser(this.user);
}
