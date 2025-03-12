import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page buildSlideTransition({
  required Widget child,
  LocalKey? key,
  String? name,
}) {
  // The page slides in from the right and exits in reverse. It also shifts to the left in
  // a parallax motion when another page enters to cover it.
  return CupertinoPage(
    key: key,
    name: name,
    child: child,
  );
}

Page buildZoomTransition({
  required Widget child,
  LocalKey? key,
  String? name,
}) {
  // Zooms and fades a new page in, zooming out the previous page. This transition
  // is designed to match the Android Q activity transition.
  return MaterialPage(
    key: key,
    name: name,
    child: child,
  );
}

CustomTransitionPage buildFadeTransition({
  required Widget child,
  LocalKey? key,
  String? name,
}) {
  return CustomTransitionPage<void>(
    key: key,
    name: name,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

CustomTransitionPage buildBottomToTopTransition({
  required Widget child,
  LocalKey? key,
  String? name,
}) {
  return CustomTransitionPage<void>(
    key: key,
    name: name,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

class CircleRevealClipper extends CustomClipper<Path> {
  final double fraction;

  CircleRevealClipper(this.fraction);

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.shortestSide * 1.5;
    return Path()
      ..addOval(Rect.fromCircle(center: center, radius: maxRadius * fraction));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

CustomTransitionPage buildCircleRevealTransition({
  required Widget child,
  LocalKey? key,
  String? name,
}) {
  return CustomTransitionPage<void>(
    key: key,
    name: name,
    child: child,
    transitionDuration: const Duration(milliseconds: 600),
    reverseTransitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      );

      return Stack(
        children: [
          // 保持前一个页面不动
          const Positioned.fill(child: ExcludeSemantics()),
          ClipPath(
            clipper: CircleRevealClipper(curvedAnimation.value),
            child: child,
          ),
        ],
      );
    },
  );
}
