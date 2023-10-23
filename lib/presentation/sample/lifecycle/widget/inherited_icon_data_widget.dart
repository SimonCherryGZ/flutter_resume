import 'package:flutter/material.dart';

class InheritedIconDataWidget extends InheritedWidget {
  const InheritedIconDataWidget(
    this.iconData, {
    super.key,
    required super.child,
  });

  final IconData iconData;

  static InheritedIconDataWidget of(BuildContext context) {
    final InheritedIconDataWidget? widget =
        context.dependOnInheritedWidgetOfExactType();
    assert(widget != null, 'No InheritedIconDataWidget found in context');
    return widget!;
  }

  @override
  bool updateShouldNotify(covariant InheritedIconDataWidget oldWidget) {
    return iconData != oldWidget.iconData;
  }
}
