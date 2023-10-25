import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/feed/feed.dart';
import 'package:flutter_resume/presentation/home/home.dart';
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
  static const _bottomNavigationItems = [
    MapEntry('首页', Icons.home),
    MapEntry('示例', Icons.dashboard),
    MapEntry('消息', Icons.message),
    MapEntry('我的', Icons.person),
  ];

  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);

  @override
  void dispose() {
    _indexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    const Center(
                      child: Text('消息'),
                    ),
                    ProfileScreen(
                      user: context.read<AppCubit>().state.signedInUser!,
                    ),
                  ],
                );
              }),
          bottomNavigationBar: HomeBottomNavigationBar(
            itemConfigs: _bottomNavigationItems,
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
    return CommonDialog.show(
      context,
      title: '提示',
      content: '确定退出 App ?',
      negativeButtonText: '取消',
      positiveButtonText: '确认退出',
    );
  }
}
