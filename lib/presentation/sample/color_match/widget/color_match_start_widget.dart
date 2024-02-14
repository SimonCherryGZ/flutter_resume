import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class ColorMatchStartWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const ColorMatchStartWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Text(
          '开始游戏',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.ss(),
          ),
        ),
      ),
    );
  }
}
