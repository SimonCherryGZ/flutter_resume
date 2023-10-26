import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class LifecycleShowcaseWidget extends StatelessWidget {
  const LifecycleShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return ShowcaseWidget(
      title: l10n.lifecycleVisualizationShowcaseTitle,
      content: l10n.lifecycleVisualizationShowcaseContent,
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
