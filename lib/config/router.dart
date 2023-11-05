import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/config/router_transition.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/conversation/conversation.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';
import 'package:flutter_resume/presentation/home/home.dart';
import 'package:flutter_resume/presentation/post/post.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_resume/presentation/login/login.dart';
import 'package:flutter_resume/presentation/welcome/welcome.dart';

class AppRouter {
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String setting = '/setting';
  static const String post = '/post';
  static const String conversation = '/conversation';
  static const String editor = '/editor';
  static const String sampleAsync = '/sample/async';
  static const String sampleKey = '/sample/key';
  static const String sampleGlobalKeyAccess = '/sample/globalKeyAccess';
  static const String sampleLifecycle = '/sample/lifecycle';
  static const String sampleAnimation = '/sample/animation';
  static const String sampleHeroAnimation = '/sample/heroAnimation';
  static const String sampleLayout = '/sample/layout';

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
        pageBuilder: (context, state) => buildFadeTransition(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: home,
        pageBuilder: (context, state) => buildSlideTransition(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
        redirect: (context, state) async {
          final isSignedIn = context.read<AppCubit>().state.isSignedIn;
          if (!isSignedIn) {
            return login;
          }
          return null;
        },
      ),
      GoRoute(
        path: setting,
        pageBuilder: (context, state) => buildSlideTransition(
          key: state.pageKey,
          child: const SettingScreen(),
        ),
      ),
      GoRoute(
        path: post,
        pageBuilder: (_, state) => buildZoomTransition(
          key: state.pageKey,
          child: PostScreen(
            feed: state.extra as Feed,
            heroTag: state.queryParameters['heroTag'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: conversation,
        pageBuilder: (context, state) => buildSlideTransition(
          key: state.pageKey,
          child: ConversationScreen(
            conversation: state.extra as Conversation,
          ),
        ),
      ),
      GoRoute(
        path: editor,
        pageBuilder: (_, state) => buildSlideTransition(
          key: state.pageKey,
          child: const EditorScreen(),
        ),
      ),
      GoRoute(
        path: sampleAsync,
        pageBuilder: (_, state) => buildSlideTransition(
          key: state.pageKey,
          child: const SampleAsyncScreen(),
        ),
      ),
      GoRoute(
        path: sampleKey,
        pageBuilder: (_, state) => buildSlideTransition(
          key: state.pageKey,
          child: const SampleKeyScreen(),
        ),
      ),
      GoRoute(
        path: sampleGlobalKeyAccess,
        pageBuilder: (_, state) => buildSlideTransition(
          key: state.pageKey,
          child: SampleGlobalKeyAccessScreen(
            globalKey: state.extra as GlobalKey,
          ),
        ),
      ),
      GoRoute(
        path: sampleLifecycle,
        pageBuilder: (_, state) => buildSlideTransition(
          key: state.pageKey,
          child: const SampleLifecycleScreen(),
        ),
      ),
      GoRoute(
        path: sampleAnimation,
        pageBuilder: (_, state) => buildSlideTransition(
          key: state.pageKey,
          child: const SampleAnimationScreen(),
        ),
      ),
      GoRoute(
        path: sampleHeroAnimation,
        pageBuilder: (_, state) => buildSlideTransition(
          key: state.pageKey,
          child: const SampleHeroAnimationScreen(),
        ),
      ),
      GoRoute(
        path: sampleLayout,
        pageBuilder: (_, state) => buildSlideTransition(
          key: state.pageKey,
          child: const SampleLayoutScreen(),
        ),
      ),
    ],
  );

  static GoRouter get router => _router;
}
