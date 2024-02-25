import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  static const _items1 = {
    'Async': AppRouter.sampleAsync,
    'Isolate': AppRouter.sampleIsolate,
    'Key': AppRouter.sampleKey,
    'State Lifecycle': AppRouter.sampleLifecycle,
    'Animation': AppRouter.sampleAnimation,
    'Layout': AppRouter.sampleLayout,
    'Optimization': AppRouter.sampleOptimization,
    'Router': AppRouter.sampleRouter,
    'App Lifecycle': AppRouter.sampleAppLifecycle,
    'Gesture': AppRouter.sampleGesture,
    'Shader': AppRouter.sampleShader,
  };

  static const _items2 = {
    'CustomScrollView': AppRouter.sampleCustomScrollView,
    'NestedScrollView': AppRouter.sampleNestedScrollView,
    'RoundedCornerHeader': AppRouter.sampleRoundedCornerHeader,
    'RoundedCornerPinnedHeader': AppRouter.sampleRoundedCornerPinnedHeader,
  };

  static const _items3 = {
    'ScreenSecurity': AppRouter.sampleScreenSecurity,
    '五十音': AppRouter.sampleGojuon,
    'Color Match': AppRouter.sampleColorMatch,
    'Card Match': AppRouter.sampleCardMatch,
    'Pathfinding': AppRouter.samplePathfinding,
    'Local Notification': AppRouter.sampleLocalNotification,
    'Custom Layout': AppRouter.sampleCustomLayout,
  };

  @override
  Widget build(BuildContext context) {
    final tabs = ['Concept', 'UI', 'Demo'];
    return DefaultTabController(
      length: tabs.length,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).disabledColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    _SubSampleScreen(_items1),
                    _SubSampleScreen(_items2),
                    _SubSampleScreen(_items3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubSampleScreen extends StatelessWidget {
  const _SubSampleScreen(Map<String, String> items) : _items = items;

  final Map<String, String> _items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.all(20.ss()),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final title = _items.keys.elementAt(index);
            final route = _items[title];
            return SampleItem(
              title: title,
              route: route!,
              onTap: () {
                context.goNamed(route);
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 20.ss());
          },
        ),
      ),
    );
  }
}
