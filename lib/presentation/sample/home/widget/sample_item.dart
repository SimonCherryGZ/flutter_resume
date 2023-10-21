import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class SampleItem extends StatelessWidget {
  final String title;
  final String route;
  final VoidCallback? onTap;

  const SampleItem({
    super.key,
    required this.title,
    required this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: 50.ss(),
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
