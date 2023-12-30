import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class RouteAwareShowcaseWidget extends StatelessWidget {
  const RouteAwareShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'RouteAware',
      content: '打开浮窗查看日志\n浮窗将在退出本页面时自动关闭\n浮窗与Navigation Observer示例共用',
      builder: (context) {
        return Center(
          child: _RouteAwareShowcaseContent(),
        );
      },
    );
  }
}

class _RouteAwareShowcaseContent extends StatefulWidget {
  @override
  State<_RouteAwareShowcaseContent> createState() =>
      _RouteAwareShowcaseContentState();
}

class _RouteAwareShowcaseContentState extends State<_RouteAwareShowcaseContent>
    with RouteAware {
  final _tag = 'RouteAwareShowcase';
  final _logController = FloatingLogController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouter.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppRouter.routeObserver.unsubscribe(this);
    _logController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    debugPrint('RouteAwareShowcase - didPopNext');
    _logController.addLog('RouteAware: didPopNext');
  }

  @override
  void didPush() {
    super.didPush();
    debugPrint('RouteAwareShowcase - didPush');
    _logController.addLog('RouteAware: didPush');
  }

  @override
  void didPop() {
    super.didPop();
    debugPrint('RouteAwareShowcase - didPop');
    _logController.addLog('RouteAware: didPop\n1s后自动关闭浮窗');
    if (_tag == DraggableStickyOverlayWidget.tag) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        DraggableStickyOverlayWidget.remove();
      });
    }
  }

  @override
  void didPushNext() {
    super.didPushNext();
    debugPrint('RouteAwareShowcase - didPushNext');
    _logController.addLog('RouteAware: didPushNext');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (_tag == DraggableStickyOverlayWidget.tag) {
              return;
            }
            FloatingLogWidget.show(
              tag: _tag,
              context: context,
              controller: _logController,
            );
          },
          child: const Text('打开浮窗'),
        ),
        SizedBox(height: 10.ss()),
        ElevatedButton(
          onPressed: () {
            context.goNamed(AppRouter.sampleSubRouteA);
          },
          child: const Text('跳转页面'),
        ),
      ],
    );
  }
}
