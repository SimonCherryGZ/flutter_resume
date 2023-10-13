import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginForgetPasswordButton extends StatelessWidget {
  const LoginForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // todo
      },
      child: Text(
        '忘记密码？',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12.ss(),
        ),
      ),
    );
  }
}
