import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/config/nav_observer.dart';
import 'package:flutter_resume/config/router_transition.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/album/album.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/conversation/conversation.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';
import 'package:flutter_resume/presentation/home/home.dart';
import 'package:flutter_resume/presentation/photo/photo.dart';
import 'package:flutter_resume/presentation/post/post.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/presentation/setting/setting.dart';
import 'package:flutter_resume/presentation/video/video.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_resume/presentation/login/login.dart';
import 'package:flutter_resume/presentation/welcome/welcome.dart';
import 'package:photo_manager/photo_manager.dart';

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
  static const String sampleIsolate = 'sampleIsolate';
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
  static const String sampleAppLifecycle = 'sampleAppLifecycle';
  static const String sampleCustomScrollView = 'sampleCustomScrollView';
  static const String sampleNestedScrollView = 'sampleNestedScrollView';
  static const String sampleRoundedCornerHeader = 'sampleRoundedCornerHeader';
  static const String sampleRoundedCornerPinnedHeader =
      'sampleRoundedCornerPinnedHeader';
  static const String sampleNestedTabBarView = 'sampleNestedTabBarView';
  static const String sampleGesture = 'sampleGesture';
  static const String sampleShader = 'sampleShader';
  static const String sampleScreenSecurity = 'sampleScreenSecurity';
  static const String sampleScreenSecurityPhotoView =
      'sampleScreenSecurityPhotoView';
  static const String sampleScreenSecurityVideoPlayer =
      'sampleScreenSecurityVideoPlayer';
  static const String sampleGojuon = 'sampleGojuon';
  static const String sampleColorMatch = 'sampleColorMatch';
  static const String sampleColorMatchClassic = 'classic';
  static const String sampleColorMatchTime = 'time';
  static const String sampleColorMatchChoice = 'choice';
  static const String sampleColorMatchRace = 'race';
  static const String sampleCardMatch = 'sampleCardMatch';
  static const String samplePathfinding = 'samplePathfinding';
  static const String sampleLocalNotification = 'sampleLocalNotification';
  static const String sampleCustomLayout = 'sampleCustomLayout';
  static const String sampleAudioPlayer = 'sampleAudioPlayer';
  static const String sampleVideoComments = 'sampleVideoComments';
  static const String sampleRust = 'sampleRust';
  static const String sampleVideoPageView = 'sampleVideoPageView';
  static const String sampleNumberSpinner = 'sampleNumberSpinner';
  static const String sampleTextToImage = 'sampleTextToImage';

  AppRouter._();

  static final MyNavObserver myNavObserver = MyNavObserver();

  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  // Unknown behavior with hot reload when using the go_router package
  // https://stackoverflow.com/a/73877637
  static final GoRouter _router = GoRouter(
    initialLocation: root,
    observers: [
      myNavObserver,
      routeObserver,
    ],
    routes: [
      GoRoute(
        path: root,
        pageBuilder: (_, __) => buildCircleRevealTransition(
          child: const WelcomeScreen(),
        ),
      ),
      GoRoute(
        path: login,
        pageBuilder: (context, state) => buildCircleRevealTransition(
          key: state.pageKey,
          name: state.name,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: home,
        pageBuilder: (context, state) => buildCircleRevealTransition(
          key: state.pageKey,
          name: state.name,
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
              name: state.name,
              child: const SettingScreen(),
            ),
          ),
          GoRoute(
            path: post,
            name: post,
            pageBuilder: (_, state) => buildZoomTransition(
              key: state.pageKey,
              name: state.name,
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
              name: state.name,
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
              name: state.name,
              child: const AlbumScreen(),
            ),
          ),
          GoRoute(
            path: editor,
            name: editor,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: EditorScreen(
                assetEntity: state.extra as AssetEntity,
              ),
            ),
          ),
          GoRoute(
            path: sampleAsync,
            name: sampleAsync,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleAsyncScreen(),
            ),
          ),
          GoRoute(
            path: sampleIsolate,
            name: sampleIsolate,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleIsolateScreen(),
            ),
          ),
          GoRoute(
            path: sampleKey,
            name: sampleKey,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleKeyScreen(),
            ),
            routes: [
              GoRoute(
                path: sampleGlobalKeyAccess,
                name: sampleGlobalKeyAccess,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
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
              name: state.name,
              child: const SampleLifecycleScreen(),
            ),
          ),
          GoRoute(
            path: sampleAnimation,
            name: sampleAnimation,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleAnimationScreen(),
            ),
            routes: [
              GoRoute(
                path: sampleHeroAnimation,
                name: sampleHeroAnimation,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
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
              name: state.name,
              child: const SampleLayoutScreen(),
            ),
          ),
          GoRoute(
            path: sampleOptimization,
            name: sampleOptimization,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleOptimizationScreen(),
            ),
          ),
          GoRoute(
            path: sampleRouter,
            name: sampleRouter,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleRouterScreen(),
            ),
            routes: [
              GoRoute(
                path: sampleSubRouteA,
                name: sampleSubRouteA,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
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
                      name: state.name,
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
          GoRoute(
            path: sampleAppLifecycle,
            name: sampleAppLifecycle,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleAppLifecycleScreen(),
            ),
          ),
          GoRoute(
            path: sampleGesture,
            name: sampleGesture,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleGestureScreen(),
            ),
          ),
          GoRoute(
            path: sampleShader,
            name: sampleShader,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleShaderScreen(),
            ),
          ),
          GoRoute(
            path: sampleCustomScrollView,
            name: sampleCustomScrollView,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleCustomScrollViewScreen(),
            ),
          ),
          GoRoute(
            path: sampleNestedScrollView,
            name: sampleNestedScrollView,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleNestedScrollViewScreen(),
            ),
          ),
          GoRoute(
            path: sampleRoundedCornerHeader,
            name: sampleRoundedCornerHeader,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleRoundedCornerHeaderScreen(),
            ),
          ),
          GoRoute(
            path: sampleRoundedCornerPinnedHeader,
            name: sampleRoundedCornerPinnedHeader,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleRoundedCornerPinnedHeaderScreen(),
            ),
          ),
          GoRoute(
            path: sampleNestedTabBarView,
            name: sampleNestedTabBarView,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleNestedTabBarViewScreen(),
            ),
          ),
          GoRoute(
            path: sampleScreenSecurity,
            name: sampleScreenSecurity,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleScreenSecurityScreen(),
            ),
            routes: [
              GoRoute(
                path: sampleScreenSecurityPhotoView,
                name: sampleScreenSecurityPhotoView,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
                  child: PhotoViewScreen(
                    imageProvider: state.extra as ImageProvider,
                  ),
                ),
              ),
              GoRoute(
                path: sampleScreenSecurityVideoPlayer,
                name: sampleScreenSecurityVideoPlayer,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
                  child: VideoPlayerScreen(
                    videoAssetPath: state.extra as String,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: sampleGojuon,
            name: sampleGojuon,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleGojuonScreen(),
            ),
          ),
          GoRoute(
            path: sampleColorMatch,
            name: sampleColorMatch,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const ColorMatchHomeScreen(),
            ),
            routes: [
              GoRoute(
                path: sampleColorMatchClassic,
                name: sampleColorMatchClassic,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
                  child: const ColorMatchClassicScreen(),
                ),
              ),
              GoRoute(
                path: sampleColorMatchTime,
                name: sampleColorMatchTime,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
                  child: const ColorMatchTimeScreen(),
                ),
              ),
              GoRoute(
                path: sampleColorMatchChoice,
                name: sampleColorMatchChoice,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
                  child: const ColorMatchChoiceScreen(),
                ),
              ),
              GoRoute(
                path: sampleColorMatchRace,
                name: sampleColorMatchRace,
                pageBuilder: (_, state) => buildSlideTransition(
                  key: state.pageKey,
                  name: state.name,
                  child: const ColorMatchRaceScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: sampleCardMatch,
            name: sampleCardMatch,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleCardMatchScreen(),
            ),
          ),
          GoRoute(
            path: samplePathfinding,
            name: samplePathfinding,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const PathfindingScreen(),
            ),
          ),
          GoRoute(
            path: sampleLocalNotification,
            name: sampleLocalNotification,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleLocalNotificationScreen(),
            ),
          ),
          GoRoute(
            path: sampleCustomLayout,
            name: sampleCustomLayout,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleCustomLayoutScreen(),
            ),
          ),
          GoRoute(
            path: sampleAudioPlayer,
            name: sampleAudioPlayer,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleAudioPlayerScreen(),
            ),
          ),
          GoRoute(
            path: sampleVideoComments,
            name: sampleVideoComments,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleVideoCommentsScreen(),
            ),
          ),
          GoRoute(
            path: sampleRust,
            name: sampleRust,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleRustScreen(),
            ),
          ),
          GoRoute(
            path: sampleVideoPageView,
            name: sampleVideoPageView,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleVideoPageViewScreen(),
            ),
          ),
          GoRoute(
            path: sampleNumberSpinner,
            name: sampleNumberSpinner,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleNumberSpinnerScreen(),
            ),
          ),
          GoRoute(
            path: sampleTextToImage,
            name: sampleTextToImage,
            pageBuilder: (_, state) => buildSlideTransition(
              key: state.pageKey,
              name: state.name,
              child: const SampleTextToImageScreen(),
            ),
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
        name: state.name,
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
            name: state.name,
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
