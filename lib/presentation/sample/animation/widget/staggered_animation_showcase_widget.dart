import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class StaggeredAnimationShowcaseWidget extends StatefulWidget {
  const StaggeredAnimationShowcaseWidget({super.key});

  @override
  State<StaggeredAnimationShowcaseWidget> createState() =>
      _StaggeredAnimationShowcaseWidgetState();
}

class _StaggeredAnimationShowcaseWidgetState
    extends State<StaggeredAnimationShowcaseWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _offsetY;
  late final Animation<double> _scale;
  late final Animation<double> _rotation;
  late final AnimationStatusListener _statusListener;

  final _containerSize = 200.0;
  final _ballSize = 80.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _offsetY = Tween<double>(
      begin: 0.0,
      end: _containerSize - _ballSize / 2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.bounceOut,
        ),
      ),
    );

    _scale = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    _rotation = Tween<double>(
      begin: 0.0,
      end: 360.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.4,
          0.7,
          curve: Curves.decelerate,
        ),
      ),
    );

    _statusListener = (status) async {
      if (!mounted) {
        return;
      }
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 300));
        _controller.reset();
        _controller.forward();
      }
    };
    _controller.addStatusListener(_statusListener);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return ShowcaseWidget(
      title: l10n.staggeredAnimationShowcaseTitle,
      content: l10n.staggeredAnimationShowcaseContent,
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              height: _containerSize,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -(_containerSize / 2) + _offsetY.value),
                    child: Transform.rotate(
                      angle: _rotation.value * pi / 180,
                      child: Transform.scale(
                        scale: _scale.value,
                        child: child,
                      ),
                    ),
                  );
                },
                child: CircleDashWidget(
                  width: _ballSize,
                  height: _ballSize,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
