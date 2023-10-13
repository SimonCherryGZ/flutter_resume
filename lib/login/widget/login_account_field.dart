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
      textInputAction: TextInputAction.next,
      maxLines: 1,
      style: TextStyle(fontSize: 14.ss()),
      decoration: InputDecoration(
        icon: Icon(
          Icons.person,
          size: 20.ss(),
        ),
        hintText: '请输入昵称或邮箱',
        hintStyle: TextStyle(fontSize: 14.ss()),
      ),
      onTap: () {
        bloc.add(UnFocusPasswordField());
      },
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: (text) {
        bloc.add(UpdateAccount(text));
      },
    );
  }
}
