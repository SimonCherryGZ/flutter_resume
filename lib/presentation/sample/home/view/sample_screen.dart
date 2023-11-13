import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  static const _items = {
    'Async': AppRouter.sampleAsync,
    'Key': AppRouter.sampleKey,
    'Lifecycle': AppRouter.sampleLifecycle,
    'Animation': AppRouter.sampleAnimation,
    'Layout': AppRouter.sampleLayout,
    'Optimization': AppRouter.sampleOptimization,
  };

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
                context.push(route);
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
