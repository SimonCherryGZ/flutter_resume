import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    Widget app = BlocBuilder<AppLocale, Locale?>(
      builder: (context, locale) {
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
          ],
          supportedLocales: L10nDelegate.supportedLocales,
          locale: locale,
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
            primarySwatch: Colors.purple,
          ),
        );
      },
    );
    app = OKToast(child: app);
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => AppLocale(L10nDelegate.defaultLocale),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AppBloc(),
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
      ],
      child: app,
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
