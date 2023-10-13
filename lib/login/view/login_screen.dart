import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/login/login.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final panelWidth = 300.ss();
    final panelHeight = 400.ss();
    final headSize = 80.ss();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: Builder(
          builder: (context) {
            return Stack(
              children: [
                Center(
                  child: Container(
                    width: panelWidth,
                    height: panelHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.ss()),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.ss()),
                    child: Column(
                      children: [
                        SizedBox(height: headSize / 2 + 10.ss()),
                        const LoginAccountField(),
                        SizedBox(height: 20.ss()),
                        const LoginPasswordField(),
                        SizedBox(height: 10.ss()),
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: (screenSize.height - panelHeight) / 2 - headSize / 2,
                  child: const LoginMonkeyHead(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
