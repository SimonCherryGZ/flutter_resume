import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/login/login.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: Builder(
          builder: (context) {
            return Center(
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
            );
          },
        ),
      ),
    );
  }
}
