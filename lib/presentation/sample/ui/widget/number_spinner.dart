import 'package:flutter/material.dart';

class NumberSpinner extends StatefulWidget {
  const NumberSpinner({
    super.key,
    required this.targetNumber,
    required this.showAnimation,
    this.unitWidth,
    this.unitHeight,
    required this.numberTextStyle,
    required this.duration,
    required this.delayBetween,
    this.curve = Curves.easeOut,
    this.controller,
    this.onCompleted,
  });

  final int targetNumber;
  final bool showAnimation;
  final double? unitWidth;
  final double? unitHeight;
  final TextStyle numberTextStyle;
  final Duration duration;
  final Duration delayBetween;
  final Curve curve;
  final NumberSpinnerController? controller;
  final VoidCallback? onCompleted;

  @override
  State<NumberSpinner> createState() => _NumberSpinnerState();
}

class _NumberSpinnerState extends State<NumberSpinner>
    with TickerProviderStateMixin {
  late final List<AnimationController> _animationControllers;
  late List<int> _numbers;
  TickerFuture? _lastAnimationComplete;
  bool _forwardRequested = false;

  @override
  void initState() {
    super.initState();
    _numbers = [];
    _animationControllers = [];
    _splitNumbers();
  }

  @override
  void didUpdateWidget(covariant NumberSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetNumber == oldWidget.targetNumber) {
      return;
    }

    _numbers.clear();
    for (final controller in _animationControllers) {
      controller.reset();
      controller.dispose();
    }
    _animationControllers.clear();
    _lastAnimationComplete?.ignore();
    _lastAnimationComplete = null;
    _splitNumbers();
    if (widget.showAnimation && _forwardRequested) {
      widget.controller?.forward();
    }
  }

  @override
  void dispose() {
    _lastAnimationComplete?.ignore();
    _lastAnimationComplete = null;
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _numbers.asMap().entries.map((entry) {
        int i = entry.key;
        int number = entry.value;
        return _NumberSpinnerUnitWidget(
          targetNumber: number,
          showAnimation: widget.showAnimation,
          width: widget.unitWidth,
          height: widget.unitHeight,
          numberTextStyle: widget.numberTextStyle,
          curve: widget.curve,
          animationController: _animationControllers[i],
        );
      }).toList(),
    );
  }

  void _splitNumbers() {
    int targetNumber = widget.targetNumber;
    if (targetNumber > 0) {
      while (targetNumber > 0) {
        _numbers.add(targetNumber % 10);
        targetNumber ~/= 10;
      }
    } else {
      _numbers.add(0);
    }

    _numbers = _numbers.reversed.toList();

    for (int i = 0; i < _numbers.length; i++) {
      _animationControllers.add(AnimationController(
        vsync: this,
        duration: widget.duration,
      ));
    }

    widget.controller?.onReset = () {
      if (_forwardRequested) {
        return;
      }
      for (final controller in _animationControllers) {
        controller.reset();
      }
    };
    widget.controller?.onForward = () async {
      if (_forwardRequested) {
        return;
      }
      _forwardRequested = true;
      int i = 0;
      for (final controller in _animationControllers.reversed) {
        i++;
        final future = controller.forward();
        if (i == _animationControllers.length) {
          _lastAnimationComplete?.ignore();
          _lastAnimationComplete = future;
        }
        await Future.delayed(widget.delayBetween);
        if (!mounted) {
          _forwardRequested = false;
          return;
        }
      }
      final animationCount = _animationControllers.length;
      final timeLimit = Duration(
        milliseconds: (widget.duration.inMilliseconds +
                widget.delayBetween.inMilliseconds) *
            animationCount,
      );
      await _lastAnimationComplete?.timeout(timeLimit);
      _lastAnimationComplete = null;
      _forwardRequested = false;
      if (mounted) {
        widget.onCompleted?.call();
      }
    };
  }
}

class _NumberSpinnerUnitWidget extends StatelessWidget {
  const _NumberSpinnerUnitWidget({
    this.width,
    this.height,
    required this.numberTextStyle,
    required this.curve,
    required this.targetNumber,
    required this.showAnimation,
    required this.animationController,
  });

  final double? width;
  final double? height;
  final TextStyle numberTextStyle;
  final Curve curve;
  final int targetNumber;
  final bool showAnimation;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final numberHeight = height ?? 0;
    final total =
        1 /* ? */ + 10 /* 0~9 */ + ((targetNumber + 1) % 10) /* 9 以下补位滚到下一循环 */;
    return SizedBox(
      width: width,
      height: numberHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: CurvedAnimation(
              parent: animationController,
              curve: curve,
            ),
            builder: (context, child) {
              return Positioned(
                top: (-numberHeight *
                    (total - 1) *
                    (showAnimation ? animationController.value : 1)),
                child: child!,
              );
            },
            child: Column(
              children: List.generate(
                total,
                (index) {
                  return SizedBox(
                    height: numberHeight,
                    child: Center(
                      child: Text(
                        index == 0 ? '?' : '${(index - 1) % 10}',
                        style: numberTextStyle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberSpinnerController {
  void reset() {
    onReset?.call();
  }

  void forward() {
    onForward?.call();
  }

  VoidCallback? onReset;
  VoidCallback? onForward;
}
