import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/login/login.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          context.read<UserRepository>(),
          context.read<AppBloc>(),
        ),
        child: Builder(
          builder: (context) {
            return MultiBlocListener(
              listeners: [
                BlocListener<LoginBloc, LoginState>(
                  listenWhen: (p, c) => p.isShowLoading != c.isShowLoading,
                  listener: (context, state) {
                    final isShowLoading = state.isShowLoading;
                    if (isShowLoading) {
                      EasyLoading.show();
                    } else {
                      EasyLoading.dismiss();
                    }
                  },
                ),
                BlocListener<LoginBloc, LoginState>(
                  listenWhen: (p, c) => p.isLoginSuccess != c.isLoginSuccess,
                  listener: (context, state) {
                    final isLoginSuccess = state.isLoginSuccess;
                    if (isLoginSuccess) {
                      context.go(AppRouter.home);
                    }
                  },
                ),
              ],
              child: Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 300.ss(),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.ss()),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30.ss()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 60.ss()),
                          const LoginAccountField(),
                          SizedBox(height: 20.ss()),
                          const LoginPasswordField(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LoginForgetPasswordButton(),
                            ],
                          ),
                          SizedBox(height: 20.ss()),
                          const LoginConfirmButton(),
                          SizedBox(height: 20.ss()),
                          const LoginButtonDivider(),
                          SizedBox(height: 20.ss()),
                          const LoginRegisterButton(),
                          SizedBox(height: 20.ss()),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -40.ss()),
                      child: const LoginMonkeyHead(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
