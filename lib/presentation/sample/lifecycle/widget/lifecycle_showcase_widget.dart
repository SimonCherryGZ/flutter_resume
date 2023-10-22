import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class LifecycleShowcaseWidget extends StatelessWidget {
  const LifecycleShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'Lifecycle',
      content: '演示 State 生命周期变化',
      builder: (context) {
        return const Column(
          children: [
            LifecycleVisualizationWidget(),
          ],
        );
      },
    );
  }
}
