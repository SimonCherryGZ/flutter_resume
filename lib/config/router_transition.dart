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
