part of 'login_bloc.dart';

class LoginState {
  final bool isFocusPassword;
  final bool isShowPassword;
  final String? account;
  final String? password;
  final bool isShowLoading;
  final bool isLoginSuccess;

  LoginState({
    required this.isFocusPassword,
    required this.isShowPassword,
    this.account,
    this.password,
    this.isShowLoading = false,
    this.isLoginSuccess = false,
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
    bool? isShowLoading,
    bool? isLoginSuccess,
  }) {
    return LoginState(
      isFocusPassword: isFocusPassword ?? this.isFocusPassword,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      account: account ?? this.account,
      password: password ?? this.password,
      isShowLoading: isShowLoading ?? this.isShowLoading,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
    );
  }
}
