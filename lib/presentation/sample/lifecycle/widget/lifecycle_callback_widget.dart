import 'package:flutter/material.dart';

class LifecycleCallbackWidget extends StatefulWidget {
  final VoidCallback? initStateCallback;
  final VoidCallback? didChangeDependenciesCallback;
  final VoidCallback? buildCallback;
  final VoidCallback? didUpdateWidgetCallback;
  final VoidCallback? activateCallback;
  final VoidCallback? deactivateCallback;
  final VoidCallback? disposeCallback;
  final WidgetBuilder builder;

  const LifecycleCallbackWidget({
    super.key,
    this.initStateCallback,
    this.didChangeDependenciesCallback,
    this.buildCallback,
    this.didUpdateWidgetCallback,
    this.activateCallback,
    this.deactivateCallback,
    this.disposeCallback,
    required this.builder,
  });

  @override
  State<LifecycleCallbackWidget> createState() =>
      _LifecycleCallbackWidgetState();
}

class _LifecycleCallbackWidgetState extends State<LifecycleCallbackWidget> {
  @override
  void initState() {
    super.initState();
    widget.initStateCallback?.call();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependenciesCallback?.call();
  }

  @override
  Widget build(BuildContext context) {
    widget.buildCallback?.call();
    return widget.builder(context);
  }

  @override
  void didUpdateWidget(covariant LifecycleCallbackWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.didUpdateWidgetCallback?.call();
  }

  @override
  void activate() {
    super.activate();
    widget.activateCallback?.call();
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.deactivateCallback?.call();
  }

  @override
  void dispose() {
    super.dispose();
    widget.disposeCallback?.call();
  }
}
