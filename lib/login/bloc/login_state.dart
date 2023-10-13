part of 'login_bloc.dart';

class LoginState {
  final bool isFocusPassword;
  final bool isShowPassword;
  final String? account;
  final String? password;

  LoginState({
    required this.isFocusPassword,
    required this.isShowPassword,
    this.account,
    this.password,
  });

  LoginState.initial()
      : this(
          isFocusPassword: false,
          isShowPassword: false,
        );

  LoginState copyWith({
    bool? isFocusPassword,
    bool? isShowPassword,
    String? account,
    String? password,
  }) {
    return LoginState(
      isFocusPassword: isFocusPassword ?? this.isFocusPassword,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      account: account ?? this.account,
      password: password ?? this.password,
    );
  }
}
