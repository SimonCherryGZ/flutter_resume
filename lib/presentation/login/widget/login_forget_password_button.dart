import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginForgetPasswordButton extends StatelessWidget {
  const LoginForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return TextButton(
      onPressed: () {
        // todo
      },
      child: Text(
        l10n.loginForgetPasswordButton,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12.ss(),
        ),
      ),
    );
  }
}
