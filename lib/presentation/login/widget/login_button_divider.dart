import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginButtonDivider extends StatelessWidget {
  const LoginButtonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.ss(),
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 10.ss()),
        Text(
          l10n.loginDivider,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 10.ss()),
        Expanded(
          child: Container(
            height: 1.ss(),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
