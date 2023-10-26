import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/login/login.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    final l10n = L10nDelegate.l10n(context);
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (p, c) => p.isShowPassword != c.isShowPassword,
      builder: (context, state) {
        final passwordShowing = state.isShowPassword;
        return TextField(
          maxLines: 1,
          obscureText: !passwordShowing,
          style: TextStyle(fontSize: 14.ss()),
          decoration: InputDecoration(
            icon: Icon(
              Icons.key,
              size: 20.ss(),
            ),
            hintText: l10n.loginInputPasswordTips,
            hintStyle: TextStyle(fontSize: 14.ss()),
            suffixIcon: FittedBox(
              child: IconButton(
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
          ),
          onTap: () {
            bloc.add(FocusPasswordField());
          },
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
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
