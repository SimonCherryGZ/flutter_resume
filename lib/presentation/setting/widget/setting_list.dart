import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';

class SettingList extends StatelessWidget {
  final List<SettingNode> settings;
  final Color sectionColor;
  final double sectionBorderRadius;
  final EdgeInsets? sectionMargin;
  final EdgeInsets? sectionPadding;
  final TextStyle? sectionTitleStyle;
  final EdgeInsets? sectionTitlePadding;
  final double tileHeight;
  final EdgeInsets? tilePadding;
  final double tilePrefixSize;
  final Color tilePrefixColor;
  final Widget? tileSuffixWidget;
  final TextStyle? tileSelectionStyle;
  final List<Widget> children;

  const SettingList({
    super.key,
    this.settings = const <SettingNode>[],
    this.sectionColor = Colors.white,
    this.sectionBorderRadius = 0,
    this.sectionMargin,
    this.sectionPadding,
    this.sectionTitleStyle,
    this.sectionTitlePadding,
    required this.tileHeight,
    this.tilePadding,
    this.tilePrefixSize = 0,
    this.tilePrefixColor = Colors.grey,
    this.tileSuffixWidget,
    this.tileSelectionStyle,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...settings.map((e) {
            if (e is SettingGroup) {
              return SettingSection(
                color: sectionColor,
                borderRadius: sectionBorderRadius,
                margin: sectionMargin,
                padding: sectionPadding,
                title: e.title,
                titleStyle: sectionTitleStyle,
                titlePadding: sectionTitlePadding,
                tiles: e.settings.map((e1) {
                  return _createTile(e1);
                }).toList(),
              );
            }
            final config = e as BaseSetting;
            return _createTile(config);
          }).toList(),
          ...children,
        ],
      ),
    );
  }

  Widget _createTile(BaseSetting setting) {
    if (setting is SettingSelection) {
      return SettingTileSelection(
        height: tileHeight,
        title: setting.title,
        padding: tilePadding,
        prefixWidget: Icon(
          setting.prefixIconData,
          size: tilePrefixSize,
          color: tilePrefixColor,
        ),
        suffixWidget: tileSuffixWidget,
        initSelection: setting.initSelection,
        selectionStyle: tileSelectionStyle,
        onPerformAction: (selection) async {
          return setting.onPerformAction?.call(selection) ?? selection;
        },
      );
    }
    final Widget? suffix;
    if (setting is SettingSwitch) {
      suffix = SettingTileSwitch(
        initValue: setting.initValue,
        onChanged: (value) {
          return setting.onPerformAction?.call(value) ?? value;
        },
      );
    } else if (setting is SettingButton) {
      suffix = tileSuffixWidget;
    } else {
      suffix = null;
    }
    return SettingTile(
      height: tileHeight,
      title: setting.title,
      padding: tilePadding,
      prefixWidget: Icon(
        setting.prefixIconData,
        size: tilePrefixSize,
        color: tilePrefixColor,
      ),
      suffixWidget: suffix,
      onTap: () {
        setting.onTap?.call();
      },
    );
  }
}
