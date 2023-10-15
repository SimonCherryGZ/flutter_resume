import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final double height;
  final EdgeInsets? padding;
  final String title;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    required this.height,
    this.padding,
    required this.title,
    this.prefixWidget,
    this.suffixWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: height,
        padding: padding,
        child: Row(
          children: [
            if (prefixWidget != null) ...[
              prefixWidget!,
            ],
            Text(title),
            const Spacer(),
            if (suffixWidget != null) ...[
              suffixWidget!,
            ],
          ],
        ),
      ),
    );
  }
}
