import 'package:flutter/material.dart';

class RepeatedRotateWrapperController {
  VoidCallback? onResume;
  VoidCallback? onPause;

  void resume() {
    onResume?.call();
  }

  void pause() {
    onPause?.call();
  }
}

class RepeatedRotateWrapper extends StatefulWidget {
  const RepeatedRotateWrapper({
    super.key,
    this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.linear,
    this.autoPlay = true,
    this.controller,
  });

  final Widget? child;
  final Duration duration;
  final Curve curve;
  final bool autoPlay;
  final RepeatedRotateWrapperController? controller;

  @override
  State<RepeatedRotateWrapper> createState() => _RepeatedRotateWrapperState();
}

class _RepeatedRotateWrapperState extends State<RepeatedRotateWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Tween<double> _tween = Tween(begin: 0, end: 1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    widget.controller?.onResume = () {
      _controller.repeat();
    };
    widget.controller?.onPause = () {
      _controller.stop();
    };

    if (widget.autoPlay) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _tween.animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      )),
      child: widget.child,
    );
  }
}
