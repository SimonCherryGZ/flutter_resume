import 'package:flutter/material.dart';

class ConstraintsLabelBox extends StatelessWidget {
  const ConstraintsLabelBox({
    super.key,
    required this.width,
    required this.height,
    required this.color,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: width,
          height: height,
          color: color,
          child: Center(
            child: Text(
              'w=$width, h=$height\n\n${constraints.toString().replaceAll('BoxConstraints', '')}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
