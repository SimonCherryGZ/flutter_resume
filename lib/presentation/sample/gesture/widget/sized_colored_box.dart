import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/gesture/gesture.dart';

class SizedColoredBox extends StatelessWidget {
  const SizedColoredBox({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    this.child,
  });

  final double width;
  final double height;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TranslucentColoredBox(
        color: color,
        child: child,
      ),
    );
  }
}
