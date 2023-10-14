import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/home/home.dart';
import 'package:oktoast/oktoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bottomNavigationItems = [
    const MapEntry('首页', Icons.home),
    const MapEntry('功能', Icons.dashboard),
    const MapEntry('消息', Icons.message),
    const MapEntry('我的', Icons.person),
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
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: _indexNotifier,
            builder: (context, index, child) {
              return IndexedStack(
                index: index,
                children: _bottomNavigationItems
                    .map((e) => Center(
                          child: Text(e.key),
                        ))
                    .toList(),
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
