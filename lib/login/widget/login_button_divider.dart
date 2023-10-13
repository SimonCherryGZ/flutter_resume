import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class LoginButtonDivider extends StatelessWidget {
  const LoginButtonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.ss(),
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 10.ss()),
        const Text(
          'or',
          style: TextStyle(
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
