import 'package:flutter/material.dart';
import 'package:flutter_resume/home/home.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_resume/login/login.dart';
import 'package:flutter_resume/welcome/welcome.dart';

class AppRouter {
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';

  AppRouter._();

  // Unknown behavior with hot reload when using the go_router package
  // https://stackoverflow.com/a/73877637
  static final GoRouter _router = GoRouter(
    initialLocation: root,
    routes: [
      GoRoute(
        path: root,
        pageBuilder: (_, __) => const NoTransitionPage(
          child: WelcomeScreen(),
        ),
      ),
      GoRoute(
        path: login,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: home,
        builder: (_, __) => const HomeScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
