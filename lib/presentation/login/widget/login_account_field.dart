import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/login/login.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginAccountField extends StatelessWidget {
  const LoginAccountField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    final l10n = L10nDelegate.l10n(context);
    return TextField(
      textInputAction: TextInputAction.next,
      maxLines: 1,
      style: TextStyle(fontSize: 14.ss()),
      decoration: InputDecoration(
        icon: Icon(
          Icons.person,
          size: 20.ss(),
        ),
        hintText: l10n.loginInputAccountTips,
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
