import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/common/common.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _showExitConfirmDialog(context);
      },
      child: const Scaffold(
        body: Center(
          child: Text('我是Home'),
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
