import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_resume/config/config.dart';
import 'package:flutter_resume/data/data.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Hot reload drive me to the initial route every time using GoRouter in flutter
  // https://github.com/flutter/flutter/issues/113323
  final router = AppRouter.router;

  @override
  Widget build(BuildContext context) {
    Widget app = BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) => p.themeColor != c.themeColor || p.locale != c.locale,
      builder: (context, state) {
        final themeColor = state.themeColor;
        return MaterialApp.router(
          title: 'FlutterResume',
          onGenerateTitle: (context) {
            return L10nDelegate.l10n(context).appName;
          },
          routerConfig: router,
          localizationsDelegates: const [
            L10nDelegate.instance,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocaleNamesLocalizationsDelegate(),
          ],
          supportedLocales: L10nDelegate.supportedLocales,
          locale: state.locale,
          builder: (context, child) {
            ScreenUtil.getInstance()
                .initFromMediaQueryData(MediaQuery.of(context));
            child = FlutterEasyLoading(child: child);
            return DevicePreview.appBuilder(context, child);
          },
          scrollBehavior: BuildConfig.isMouseDraggableForWebAndDesktop
              ? CustomScrollBehavior()
              : null,
          theme: ThemeData(
            primarySwatch: themeColor,
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeColor,
              primary: themeColor,
              brightness: Brightness.light,
              surfaceTint: Colors.transparent,
            ),
            iconTheme: IconThemeData(
              size: 24.0,
              fill: 0.0,
              weight: 400.0,
              grade: 0.0,
              opticalSize: 48.0,
              color: themeColor,
              opacity: 0.8,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: themeColor,
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 24.0,
              ),
              titleTextStyle: Typography.dense2014.titleLarge,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(themeColor),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(const TextStyle(
                  color: Colors.white,
                )),
                // Add more customizations as needed
              ),
            ),
            dividerTheme: DividerThemeData(
              thickness: 0.5.ss(),
            ),
          ),
        );
      },
    );
    app = OKToast(child: app);
    return MultiProvider(
      providers: [
        RepositoryProvider<SettingRepository>(
          create: (context) => SettingRepositoryImpl(),
          lazy: false,
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImpl(),
          lazy: false,
        ),
        RepositoryProvider<AdRepository>(
          create: (context) => AdRepositoryImpl(),
          lazy: false,
        ),
        RepositoryProvider<FeedRepository>(
          create: (context) => FeedRepositoryImpl(),
          lazy: false,
        ),
        RepositoryProvider<PostRepository>(
          create: (context) => PostRepositoryImpl(),
          lazy: false,
        ),
        RepositoryProvider<ConversationRepository>(
          create: (context) => ConversationRepositoryImpl(),
          lazy: false,
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              BlocProvider(
                create: (context) => AppCubit(
                  context.read<UserRepository>(),
                  context.read<SettingRepository>(),
                ),
                lazy: false,
              ),
            ],
            child: app,
          );
        },
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  /// desktop 和 web 版本默认关闭鼠标 drag 滑动
  /// https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag#migration-guide
  /// https://github.com/flutter/flutter/pull/81569
  /// https://github.com/flutter/flutter/issues/91292
  @override
  Set<PointerDeviceKind> get dragDevices => {
        ...super.dragDevices,
        PointerDeviceKind.mouse,
      };
}
