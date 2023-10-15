import 'dart:async';

import 'package:flutter/material.dart';

abstract class SettingNode {}

abstract class BaseSetting extends SettingNode {
  final String title;
  final IconData? prefixIconData;
  final VoidCallback? onTap;
  final FutureOr<T> Function<T>(T value)? onPerformAction;

  BaseSetting({
    required this.title,
    this.prefixIconData,
    this.onTap,
    this.onPerformAction,
  });
}

class SettingButton extends BaseSetting {
  SettingButton({
    required super.title,
    super.onTap,
    super.onPerformAction,
  });
}

class SettingSelection extends BaseSetting {
  final String initSelection;

  SettingSelection({
    required super.title,
    required this.initSelection,
    super.onPerformAction,
  });
}

class SettingSwitch extends BaseSetting {
  final bool initValue;

  SettingSwitch({
    required super.title,
    required this.initValue,
    super.onPerformAction,
  });
}

class SettingGroup extends SettingNode {
  final String? title;
  final List<BaseSetting> settings;

  SettingGroup({
    this.title,
    this.settings = const <BaseSetting>[],
  });
}
