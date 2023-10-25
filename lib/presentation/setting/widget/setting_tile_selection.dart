import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';
import 'package:flutter_resume/utils/utils.dart';

class SettingTileSelection extends StatefulWidget {
  final double height;
  final EdgeInsets? padding;
  final String title;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String initSelection;
  final TextStyle? selectionStyle;
  final Future<String>? Function(String selection)? onPerformAction;

  const SettingTileSelection({
    super.key,
    required this.height,
    this.padding,
    required this.title,
    this.prefixWidget,
    this.suffixWidget,
    required this.initSelection,
    this.selectionStyle,
    required this.onPerformAction,
  });

  @override
  State<SettingTileSelection> createState() => _SettingTileSelectionState();
}

class _SettingTileSelectionState extends State<SettingTileSelection> {
  String _selection = '';

  @override
  void initState() {
    super.initState();
    _selection = widget.initSelection;
  }

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      height: widget.height,
      title: widget.title,
      padding: widget.padding,
      prefixWidget: widget.prefixWidget,
      suffixWidget: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 150.ss(),
            ),
            child: Text(
              _selection,
              style: widget.selectionStyle,
              maxLines: 1,
            ),
          ),
          if (widget.suffixWidget != null) ...[
            widget.suffixWidget!,
          ],
        ],
      ),
      onTap: () async {
        _selection =
            await widget.onPerformAction?.call(_selection) ?? _selection;
        setState(() {});
      },
    );
  }
}
