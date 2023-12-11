import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/config/router_transition.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/album/album.dart';
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
  static const String setting = 'setting';
  static const String post = 'post';
  static const String conversation = 'conversation';
  static const String album = 'album';
  static const String editor = 'editor';
  static const String sampleAsync = 'sampleAsync';
  static const String sampleKey = 'sampleKey';
  static const String sampleGlobalKeyAccess = 'sampleGlobalKeyAccess';
  static const String sampleLifecycle = 'sampleLifecycle';
  static const String sampleAnimation = 'sampleAnimation';
  static const String sampleHeroAnimation = 'sampleHeroAnimation';
  static const String sampleLayout = 'sampleLayout';
  static const String sampleOptimization = 'sampleOptimization';
  static const String sampleRouter = 'sampleRouter';
  static const String sampleSubRouteA = 'sampleSubRouteA';
  static const String sampleSubRouteB = 'sampleSubRouteB';
  static const String sampleSubRouteC_1 = 'sampleSubRouteC_1';
  static const String sampleSubRouteD_1 = 'sampleSubRouteD_1';
  static const String sampleSubRouteC_2 = 'sampleSubRouteC_2';
  static const String sampleSubRouteD_2 = 'sampleSubRouteD_2';

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
        routes: [
          GoRoute(
            path: setting,
            name: setting,
            pageBuilder: (context, state) => buildSlideTransition(
              key: state.pageKey,
              child: const SettingScreen(),
            ),
          ),
          GoRoute(
            path: post,
            name: post,
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
            name: conversation,
            pageBuilder: (context, state) => buildSlideTransition(
              key: state.pageKey,
              child: ConversationScreen(
                conversation: state.extra as Conversation,
              ),
            ),
          ),
          GoRoute(
            path: album,
            name: album,
            pageBuilder: (_, state) => buildBottomToTopTransition(
              key: state.pageKey,
              child: const AlbumScreen(),
            ),
          ),
          GoRoute(
            path: editor,
            name: editor,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              child: const EditorScreen(),
            ),
          ),
          GoRoute(
            path: sampleAsync,
            name: sampleAsync,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              child: const SampleAsyncScreen(),
            ),
          ),
          GoRoute(
            path: sampleKey,
            name: sampleKey,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              child: const SampleKeyScreen(),
            ),
            routes: [
              GoRoute(
                path: sampleGlobalKeyAccess,
                name: sampleGlobalKeyAccess,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  child: SampleGlobalKeyAccessScreen(
                    globalKey: state.extra as GlobalKey,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: sampleLifecycle,
            name: sampleLifecycle,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              child: const SampleLifecycleScreen(),
            ),
          ),
          GoRoute(
            path: sampleAnimation,
            name: sampleAnimation,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              child: const SampleAnimationScreen(),
            ),
            routes: [
              GoRoute(
                path: sampleHeroAnimation,
                name: sampleHeroAnimation,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  child: const SampleHeroAnimationScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: sampleLayout,
            name: sampleLayout,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              child: const SampleLayoutScreen(),
            ),
          ),
          GoRoute(
            path: sampleOptimization,
            name: sampleOptimization,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              child: const SampleOptimizationScreen(),
            ),
          ),
          GoRoute(
            path: sampleRouter,
            name: sampleRouter,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              child: const SampleRouterScreen(),
            ),
            routes: [
              GoRoute(
                path: sampleSubRouteA,
                name: sampleSubRouteA,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  child: const SampleSubRouteScreen(
                    label: 'A',
                    nextRoutePath: sampleSubRouteB,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: sampleSubRouteB,
                    name: sampleSubRouteB,
                    pageBuilder: (_, state) => buildSlideTransition(
                      key: state.pageKey,
                      child: const SampleSubRouteScreen(
                        label: 'B',
                        nextRoutePath: sampleSubRouteC_1,
                      ),
                    ),
                    routes: [
                      getSampleSubRouteC(
                        sampleSubRouteC_1,
                        sampleSubRouteD_1,
                      ),
                    ],
                  ),
                ],
              ),
              getSampleSubRouteC(
                sampleSubRouteC_2,
                sampleSubRouteD_2,
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static GoRoute getSampleSubRouteC(String pathC, String pathD) {
    return GoRoute(
      path: pathC,
      name: pathC,
      pageBuilder: (_, state) => buildSlideTransition(
        key: state.pageKey,
        child: SampleSubRouteScreen(
          label: 'C',
          nextRoutePath: pathD,
        ),
      ),
      routes: [
        GoRoute(
          path: pathD,
          name: pathD,
          pageBuilder: (_, state) => buildSlideTransition(
            key: state.pageKey,
            child: const SampleSubRouteScreen(
              label: 'D',
            ),
          ),
        ),
      ],
    );
  }

  static GoRouter get router => _router;
}
