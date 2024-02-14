import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class ColorMatchEndWidget extends StatelessWidget {
  final int score;
  final VoidCallback? onTap;

  const ColorMatchEndWidget({
    Key? key,
    required this.score,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: $score',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.ss(),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              '重新开始游戏',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.ss(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
