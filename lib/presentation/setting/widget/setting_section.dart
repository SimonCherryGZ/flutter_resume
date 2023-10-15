import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';
import 'package:flutter_resume/utils/utils.dart';

class SettingSection extends StatelessWidget {
  final Color color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double borderRadius;
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsets? titlePadding;
  final List<Widget> tiles;

  const SettingSection({
    super.key,
    this.color = Colors.white,
    this.margin,
    this.padding,
    this.borderRadius = 0,
    this.title,
    this.titleStyle,
    this.titlePadding,
    this.tiles = const <SettingTile>[],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: titlePadding ?? EdgeInsets.zero,
            child: Text(
              title!,
              style: titleStyle,
            ),
          ),
        ],
        Container(
          margin: margin,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: padding,
            itemBuilder: (context, index) {
              return tiles[index];
            },
            separatorBuilder: (context, index) {
              return Divider(height: 1.ss());
            },
            itemCount: tiles.length,
          ),
        ),
      ],
    );
  }
}
