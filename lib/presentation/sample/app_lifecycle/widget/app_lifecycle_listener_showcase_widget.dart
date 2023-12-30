import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:photo_manager/photo_manager.dart';

class AppLifecycleListenerShowcaseWidget extends StatelessWidget {
  const AppLifecycleListenerShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'AppLifecycleListener',
      content: '通过日志观察应用生命周期变化，举例操作:\n1.退回桌面再切回来\n2.跳转到其它应用\n3.下拉系统菜单',
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              height: 300.ss(),
              child: _AppLifecycleListenerContent(),
            ),
            SizedBox(height: 20.ss()),
            ElevatedButton(
              onPressed: () {
                PhotoManager.openSetting();
              },
              child: const Text('打开系统设置'),
            ),
            SizedBox(height: 20.ss()),
            if (Platform.isAndroid) ...[
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('退出应用'),
              ),
              SizedBox(height: 20.ss()),
            ],
          ],
        );
      },
    );
  }
}

class _AppLifecycleListenerContent extends StatefulWidget {
  @override
  State<_AppLifecycleListenerContent> createState() =>
      _AppLifecycleListenerContentState();
}

class _AppLifecycleListenerContentState
    extends State<_AppLifecycleListenerContent> {
  late final AppLifecycleListener _listener;
  final List<MapEntry<int, String>> _logList = [];
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _listener = AppLifecycleListener(
      onResume: () {
        debugPrint('AppLifecycleListener: onResume');
        _addLog('onResume');
      },
      onInactive: () {
        debugPrint('AppLifecycleListener: onInactive');
        _addLog('onInactive');
      },
      onHide: () {
        debugPrint('AppLifecycleListener: onHide');
        _addLog('onHide');
      },
      onShow: () {
        debugPrint('AppLifecycleListener: onShow');
        _addLog('onShow');
      },
      onPause: () {
        debugPrint('AppLifecycleListener: onPause');
        _addLog('onPause');
      },
      onRestart: () {
        debugPrint('AppLifecycleListener: onRestart');
        _addLog('onRestart');
      },
      onDetach: () {
        debugPrint('AppLifecycleListener: onDetach');
        _addLog('onDetach');
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.ss(),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.ss(),
                color: Colors.grey,
              ),
            ),
            child: ListView.separated(
              controller: _scrollController,
              itemCount: _logList.length,
              itemBuilder: (context, index) {
                final log = _logList[index];
                return SizedBox(
                  height: 40.ss(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(log.key).toString(),
                        style: TextStyle(
                          fontSize: 11.ss(),
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        log.value,
                        style: TextStyle(
                          fontSize: 14.ss(),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              padding: EdgeInsets.symmetric(
                horizontal: 10.ss(),
                vertical: 10.ss(),
              ),
            ),
          ),
        ),
        SizedBox(height: 30.ss()),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _logList.clear();
            });
          },
          child: const Text('清空日志'),
        ),
      ],
    );
  }

  void _addLog(String log) {
    setState(() {
      _logList.add(MapEntry(
        DateTime.now().millisecondsSinceEpoch,
        log,
      ));
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150),
          curve: Curves.fastOutSlowIn,
        );
      });
    });
  }
}
