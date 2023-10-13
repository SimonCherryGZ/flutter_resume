part of 'login_bloc.dart';

abstract class LoginEvent {}

class FocusPasswordField extends LoginEvent {}

class UnFocusPasswordField extends LoginEvent {}

class ShowPassword extends LoginEvent {}

class HidePassword extends LoginEvent {}

class UpdateAccount extends LoginEvent {
  final String? account;

  UpdateAccount(this.account);
}

class UpdatePassword extends LoginEvent {
  final String? password;

  UpdatePassword(this.password);
}
