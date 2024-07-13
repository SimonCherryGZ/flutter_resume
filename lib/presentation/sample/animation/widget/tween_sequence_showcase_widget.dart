import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class TweenSequenceShowcaseWidget extends StatefulWidget {
  const TweenSequenceShowcaseWidget({super.key});

  @override
  State<TweenSequenceShowcaseWidget> createState() =>
      _TweenSequenceShowcaseWidgetState();
}

class _TweenSequenceShowcaseWidgetState
    extends State<TweenSequenceShowcaseWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final _tweenSequence = TweenSequence(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.12)
            .chain(CurveTween(curve: Curves.ease)),
        weight: 450 / 1000,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.12, end: 0.96)
            .chain(CurveTween(curve: Curves.ease)),
        weight: 300 / 1000,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.96, end: 1.0)
            .chain(CurveTween(curve: Curves.ease)),
        weight: 250 / 1000,
      ),
    ],
  );

  bool isToasted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'Tween Sequence',
      content:
          '🍞 动画由 3 段 Tween 拼接而成\n【0.00 - 0.45】: 上升至越界\n【0.45 - 0.75】: 下降至越界\n【0.75 - 1.00】: 回弹至基准线',
      builder: (context) {
        return Center(
          child: Stack(
            children: [
              SizedBox(
                width: 150.ss(),
                height: 150.ss(),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 50.ss(),
                child: Container(
                  width: 120.ss(),
                  height: 8.ss(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.ss()),
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned(
                left: 15.ss(),
                right: 15.ss(),
                bottom: 20.ss(),
                child: ClipRect(
                  clipper: _CustomClipper(),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final value = _tweenSequence.animate(_controller).value;
                      return Transform.translate(
                        offset: Offset(
                          0,
                          (1 - value) * 60.ss(),
                        ),
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (_controller.isCompleted) {
                          _controller.reverse();
                          setState(() {
                            isToasted = false;
                          });
                        } else if (_controller.isDismissed) {
                          _controller.forward();
                          setState(() {
                            isToasted = true;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 120.ss(),
                        height: 120.ss(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.ss()),
                          border: Border.all(
                            color: isToasted
                                ? const Color(0xFFDAA520)
                                : const Color(0xFFFFD700),
                            width: 4.ss(),
                          ),
                          color: isToasted
                              ? const Color(0xFFF0E68C)
                              : const Color(0xFFFFFFE0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CustomClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, -64.ss(), size.width, size.height + 30.ss());
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
