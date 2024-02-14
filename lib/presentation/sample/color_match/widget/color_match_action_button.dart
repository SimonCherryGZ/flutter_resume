import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class ColorMatchActionButton extends StatelessWidget {
  const ColorMatchActionButton({
    super.key,
    required this.color,
    required this.iconData,
    this.onTap,
  });

  final Color color;
  final IconData iconData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.ss(),
        height: 60.ss(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.ss())),
          color: color,
        ),
        child: Center(
          child: Icon(
            iconData,
            size: 50.ss(),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
