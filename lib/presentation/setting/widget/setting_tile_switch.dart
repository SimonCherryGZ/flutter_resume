import 'dart:async';

import 'package:flutter/material.dart';

class SettingTileSwitch extends StatefulWidget {
  final bool initValue;
  final FutureOr<bool> Function(bool value) onChanged;

  const SettingTileSwitch({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  @override
  State<SettingTileSwitch> createState() => _SettingTileSwitchState();
}

class _SettingTileSwitchState extends State<SettingTileSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _value,
      onChanged: (value) async {
        _value = await widget.onChanged(value);
        setState(() {});
      },
    );
  }
}
