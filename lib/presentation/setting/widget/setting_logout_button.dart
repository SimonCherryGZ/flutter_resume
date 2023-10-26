import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/utils/utils.dart';

class SettingLogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const SettingLogoutButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50.ss(),
        margin: EdgeInsets.symmetric(horizontal: 20.ss(), vertical: 40.ss()),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.ss()),
        ),
        child: Center(
          child: Text(l10n.settingLogoutButton),
        ),
      ),
    );
  }
}
