import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

typedef StateCallback = void Function(LifecycleState state);

class LifecycleCallbackWidgetWrapper extends StatelessWidget {
  const LifecycleCallbackWidgetWrapper({
    super.key,
    this.stateCallback,
    this.color,
  });

  final StateCallback? stateCallback;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LifecycleCallbackWidget(
      initStateCallback: () {
        _callback(LifecycleState.initState);
      },
      didChangeDependenciesCallback: () {
        _callback(LifecycleState.didChangeDependencies);
      },
      buildCallback: () {
        _callback(LifecycleState.build);
      },
      didUpdateWidgetCallback: () {
        _callback(LifecycleState.didUpdateWidget);
      },
      activateCallback: () {
        _callback(LifecycleState.activate);
      },
      deactivateCallback: () {
        _callback(LifecycleState.deactivate);
      },
      disposeCallback: () {
        _callback(LifecycleState.dispose);
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

  void _callback(LifecycleState state) {
    if (stateCallback != null) {
      debugPrint(state.toString());
      stateCallback!(state);
    }
  }
}
