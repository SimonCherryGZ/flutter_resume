import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/login/login.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginConfirmButton extends StatelessWidget {
  const LoginConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (p, c) => p.account != c.account || p.password != c.password,
      builder: (context, state) {
        final enable = (state.account?.isNotEmpty ?? false) && (state.password?.isNotEmpty ?? false);
        return GestureDetector(
          onTap: () {
            if (enable) {
              // todo
              debugPrint('点击登录');
            }
          },
          child: Container(
            width: 200.ss(),
            height: 40.ss(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.ss()),
              color: Theme.of(context).primaryColor.withOpacity(enable ? 1 : 0.3),
            ),
            child: Center(
              child: Text(
                '登录',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.ss(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
