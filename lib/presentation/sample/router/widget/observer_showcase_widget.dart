import 'package:flutter/material.dart';
import 'package:flutter_resume/config/nav_observer.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class ObserverShowcaseWidget extends StatelessWidget {
  const ObserverShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'Navigation Observer',
      content: '打开浮窗查看日志',
      builder: (context) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                DraggableStickyOverlayWidget.show(
                  context: context,
                  view: _ObserverLogWidget(
                    key: GlobalKey(),
                  ),
                  viewSize: Size(
                    MediaQuery.sizeOf(context).width * 0.8,
                    300.ss(),
                  ),
                );
              },
              child: const Text('打开浮窗'),
            ),
          ],
        );
      },
    );
  }
}

class _ObserverLogWidget extends StatefulWidget {
  const _ObserverLogWidget({Key? key}) : super(key: key);

  @override
  State<_ObserverLogWidget> createState() => _ObserverLogWidgetState();
}

class _ObserverLogWidgetState extends State<_ObserverLogWidget> {
  late final NavObserverCallback _pushCallback;
  late final NavObserverCallback _popCallback;
  late final NavObserverCallback _removeCallback;
  late final NavObserverCallback _replaceCallback;
  final List<String> _logList = [];
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    debugPrint('_ObserverLogWidgetState - initState');
    _pushCallback = _createNavObserverCallback('DidPush');
    _popCallback = _createNavObserverCallback('DidPop');
    _removeCallback = _createNavObserverCallback('DidRemove');
    _replaceCallback = _createNavObserverCallback('DidReplace');
    AppRouter.myNavObserver.addDidPushCallback(_pushCallback);
    AppRouter.myNavObserver.addDidPopCallback(_popCallback);
    AppRouter.myNavObserver.addDidRemoveCallback(_removeCallback);
    AppRouter.myNavObserver.addDidReplaceCallback(_replaceCallback);

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    debugPrint('_ObserverLogWidgetState - dispose');
    AppRouter.myNavObserver.removeDidPushCallback(_pushCallback);
    AppRouter.myNavObserver.removeDidPopCallback(_popCallback);
    AppRouter.myNavObserver.removeDidRemoveCallback(_removeCallback);
    AppRouter.myNavObserver.removeDidReplaceCallback(_replaceCallback);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _ObserverLogWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('_ObserverLogWidgetState - didUpdateWidget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('_ObserverLogWidgetState - didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_ObserverLogWidgetState - build');
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width * 0.8,
      height: 300.ss(),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: 10.ss(),
                vertical: 10.ss(),
              ),
              itemCount: _logList.length,
              itemBuilder: (context, index) {
                final log = _logList[index];
                return SizedBox(
                  height: 50.ss(),
                  child: Text(
                    log,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          SizedBox(height: 10.ss()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _logList.clear();
                  });
                },
                child: const Text('Clear'),
              ),
              ElevatedButton(
                onPressed: () {
                  DraggableStickyOverlayWidget.remove();
                },
                child: const Text('Close'),
              ),
            ],
          ),
          SizedBox(height: 10.ss()),
        ],
      ),
    );
  }

  NavObserverCallback _createNavObserverCallback(String tag) {
    return (route, previousRoute) {
      setState(() {
        _logList.add(
            '$tag:\nroute=${route?.settings.name}\npreviousRoute=${previousRoute?.settings.name}');
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 150),
            curve: Curves.fastOutSlowIn,
          );
        });
      });
    };
  }
}
