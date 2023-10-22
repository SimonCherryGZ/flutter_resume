import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class LifecycleVisualizationItemWidget extends StatefulWidget {
  const LifecycleVisualizationItemWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  State<LifecycleVisualizationItemWidget> createState() =>
      _LifecycleVisualizationItemWidgetState();
}

class _LifecycleVisualizationItemWidgetState
    extends State<LifecycleVisualizationItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
    final tween = Tween(begin: 0.0, end: 1.0);
    _animation = tween.animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LifecycleVisualizationItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final value = _animation.value;
        return Container(
          width: 200.ss(),
          height: 50.ss(),
          decoration: BoxDecoration(
            color: Color.lerp(Colors.white, Colors.yellow, value),
            borderRadius: BorderRadius.circular(10.ss()),
            border: Border.all(
              width: 2.ss(),
              color: Colors.black,
            ),
          ),
          child: Center(
            child: Text(widget.label),
          ),
        );
      },
    );
  }
}
