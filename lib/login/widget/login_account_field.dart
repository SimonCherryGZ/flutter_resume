import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/login/login.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginAccountField extends StatelessWidget {
  const LoginAccountField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return TextField(
      maxLines: 1,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 12.ss()),
      decoration: InputDecoration(
        icon: const Icon(Icons.person),
        hintText: '请输入昵称或邮箱',
        hintStyle: TextStyle(fontSize: 12.ss()),
      ),
      onTap: () {
        bloc.add(UnFocusPasswordField());
      },
      onChanged: (text) {
        bloc.add(UpdateAccount(text));
      },
    );
  }
}
