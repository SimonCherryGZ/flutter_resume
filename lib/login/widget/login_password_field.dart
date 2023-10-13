import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/login/login.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (p, c) => p.isShowPassword != c.isShowPassword,
      builder: (context, state) {
        final passwordShowing = state.isShowPassword;
        return TextField(
          maxLines: 1,
          obscureText: !passwordShowing,
          style: TextStyle(fontSize: 12.ss()),
          decoration: InputDecoration(
            icon: const Icon(Icons.key),
            hintText: '请输入密码',
            hintStyle: TextStyle(fontSize: 12.ss()),
            suffixIcon: IconButton(
              onPressed: () {
                if (passwordShowing) {
                  bloc.add(HidePassword());
                } else {
                  bloc.add(ShowPassword());
                }
              },
              icon: Icon(
                passwordShowing ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          onTap: () {
            bloc.add(FocusPasswordField());
          },
          onTapOutside: (_) {
            bloc.add(UnFocusPasswordField());
          },
          onChanged: (text) {
            bloc.add(UpdatePassword(text));
          },
        );
      },
    );
  }
}
