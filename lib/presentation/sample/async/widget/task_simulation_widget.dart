import 'package:flutter/material.dart';

class Task {
  final int durationInMs;
  final int delayInMs;

  Task({
    required this.durationInMs,
    required this.delayInMs,
  });
}

class TaskSimulationWidget extends StatelessWidget {
  const TaskSimulationWidget({
    super.key,
    this.tasks = const <Task>[],
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks
          .map((e) =>
              _ItemWidget(durationInMs: e.durationInMs, delayInMs: e.delayInMs))
          .toList(),
    );
  }
}

class _ItemWidget extends StatefulWidget {
  final int durationInMs;
  final int delayInMs;

  const _ItemWidget({
    required this.durationInMs,
    required this.delayInMs,
  });

  @override
  State<_ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<_ItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationInMs),
    );
    final tween = Tween(begin: 0.0, end: 1.0);
    _animation = tween.animate(_controller);

    Future.delayed(Duration(milliseconds: widget.delayInMs)).then((value) {
      if (!mounted) {
        return;
      }
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Slider(value: _animation.value, onChanged: (_) {});
      },
    );
  }
}
