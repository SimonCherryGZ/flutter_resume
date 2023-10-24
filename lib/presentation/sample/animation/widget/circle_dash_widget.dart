import 'package:flutter/material.dart';

class CircleDashWidget extends StatelessWidget {
  const CircleDashWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: width / 20,
        ),
      ),
      child: Icon(
        Icons.flutter_dash,
        size: width / 2,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
