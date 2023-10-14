import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class HomeBottomActionButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const HomeBottomActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed?.call();
      },
      iconSize: 40.ss(),
      padding: EdgeInsets.only(
        bottom: 5.ss(),
        left: 5.ss(),
        right: 5.ss(),
      ),
      icon: Icon(
        Icons.add_box_rounded,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
