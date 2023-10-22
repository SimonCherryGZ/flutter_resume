import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class LifecycleVisualizationItemWidgetWrapper extends StatelessWidget {
  final String label;
  final Stream<LifecycleState> stream;

  LifecycleVisualizationItemWidgetWrapper({
    required this.label,
    required this.stream,
  }) : super(key: ValueKey(label));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return LifecycleVisualizationItemWidget(label: label);
      },
    );
  }
}
