import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/config/notification_service.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/feed/feed.dart';
import 'package:flutter_resume/presentation/home/home.dart';
import 'package:flutter_resume/presentation/message/message.dart';
import 'package:flutter_resume/presentation/profile/profile.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(Init()),
      lazy: false,
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);
  late final StreamSubscription _selectNotificationSubscription;

  @override
  void initState() {
    super.initState();
    _selectNotificationSubscription = NotificationService()
        .selectNotificationStream
        .stream
        .listen((String? payload) async {
      if (!mounted || payload == null) {
        return;
      }
      context.goNamed(payload);
    });
  }

  @override
  void dispose() {
    _selectNotificationSubscription.cancel();
    _indexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    final bottomNavigationItems = [
      MapEntry(l10n.homeBottomNavigationBarItemHome, Icons.home),
      MapEntry(l10n.homeBottomNavigationBarItemSample, Icons.dashboard),
      MapEntry(l10n.homeBottomNavigationBarItemMessage, Icons.message),
      MapEntry(l10n.homeBottomNavigationBarItemProfile, Icons.person),
    ];
    final bloc = context.read<HomeBloc>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          return;
        }
        final canPop = await _showExitConfirmDialog(context);
        if (canPop) {
          SystemNavigator.pop();
        }
      },
      child: BlocListener<AppCubit, AppState>(
        listenWhen: (p, c) {
          return p.isSignedIn != c.isSignedIn && !c.isSignedIn;
        },
        listener: (context, state) {
          context.go(AppRouter.login);
        },
        child: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: _indexNotifier,
            builder: (context, index, child) {
              return IndexedStack(
                index: index,
                children: [
                  const FeedScreen(),
                  const SampleScreen(),
                  const MessageScreen(),
                  ProfileScreen(
                    user: context.read<AppCubit>().state.signedInUser!,
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: HomeBottomNavigationBar(
            itemConfigs: bottomNavigationItems,
            onTapItem: (index) {
              _indexNotifier.value = index;
            },
            onTapActionButton: () {
              bloc.add(DismissActionTips());
              _handleJumpToAlbum(context);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitConfirmDialog(BuildContext context) async {
    final l10n = L10nDelegate.l10n(context);
    return CommonDialog.show(
      context,
      title: l10n.exitConfirmDialogTitle,
      content: l10n.exitConfirmDialogContent,
      negativeButtonText: l10n.exitConfirmDialogNegativeButtonText,
      positiveButtonText: l10n.exitConfirmDialogPositiveButtonText,
    );
  }

  Future<void> _handleJumpToAlbum(BuildContext context) async {
    final goRouter = GoRouter.of(context);
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
      showToast('未授予相册权限');
      return;
    }
    goRouter.goNamed(AppRouter.album);
  }
}
