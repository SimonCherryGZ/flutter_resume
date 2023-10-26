import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginRegisterButton extends StatelessWidget {
  const LoginRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return GestureDetector(
      onTap: () {
        // todo
      },
      child: Container(
        width: 200.ss(),
        height: 40.ss(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.ss()),
          border: Border.all(
            color: Colors.black87,
            width: 1.ss(),
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            l10n.loginRegisterButton,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.ss(),
            ),
          ),
        ),
      ),
    );
  }
}
