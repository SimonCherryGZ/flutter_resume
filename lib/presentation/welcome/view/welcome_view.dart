import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/utils/utils.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flutter_dash,
            size: 100.ss(),
          ),
          SizedBox(height: 20.ss()),
          Text(
            L10nDelegate.l10n(context).appName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.ss(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.ss()),
          Text(
            l10n.welcomeScreenDescription,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10.ss(),
            ),
          ),
          SizedBox(height: 100.ss()),
        ],
      ),
    );
  }
}
