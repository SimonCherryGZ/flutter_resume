import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/login/login.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginMonkeyHead extends StatelessWidget {
  const LoginMonkeyHead({super.key});

  @override
  Widget build(BuildContext context) {
    final headSize = 80.ss();
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (p, c) => p.isFocusPassword != c.isFocusPassword,
      builder: (context, state) {
        final passwordTyping = state.isFocusPassword;
        return Image.asset(
          'assets/images/monkey_face_${passwordTyping ? 2 : 1}.png',
          width: headSize,
          height: headSize,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
