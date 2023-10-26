import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);

  @override
  void dispose() {
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
    return WillPopScope(
      onWillPop: () {
        return _showExitConfirmDialog(context);
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
              }),
          bottomNavigationBar: HomeBottomNavigationBar(
            itemConfigs: bottomNavigationItems,
            onTapItem: (index) {
              _indexNotifier.value = index;
            },
            onTapActionButton: () {
              // todo
              showToast('TODO: Center Action Button');
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
}
