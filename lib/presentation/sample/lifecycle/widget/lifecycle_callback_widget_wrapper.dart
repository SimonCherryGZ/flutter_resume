import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class LifecycleCallbackWidgetWrapper extends StatelessWidget {
  const LifecycleCallbackWidgetWrapper({
    super.key,
    this.stateController,
    this.color,
  });

  final StreamController<LifecycleState>? stateController;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final controller = stateController;
    return LifecycleCallbackWidget(
      initStateCallback: () {
        if (controller != null) {
          debugPrint('initState');
          controller.add(LifecycleState.initState);
        }
      },
      didChangeDependenciesCallback: () {
        if (controller != null) {
          debugPrint('didChangeDependencies');
          controller.add(LifecycleState.didChangeDependencies);
        }
      },
      buildCallback: () {
        if (controller != null) {
          debugPrint('build');
          controller.add(LifecycleState.build);
        }
      },
      didUpdateWidgetCallback: () {
        if (controller != null) {
          debugPrint('didUpdateWidget');
          controller.add(LifecycleState.didUpdateWidget);
        }
      },
      deactivateCallback: () {
        if (controller != null) {
          debugPrint('deactivate');
          controller.add(LifecycleState.deactivate);
        }
      },
      disposeCallback: () {
        if (controller != null) {
          debugPrint('dispose');
          controller.add(LifecycleState.dispose);
        }
      },
      builder: (context) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: const Icon(
            Icons.flutter_dash,
            color: Colors.white,
            size: 40,
          ),
        );
      },
    );
  }
}
