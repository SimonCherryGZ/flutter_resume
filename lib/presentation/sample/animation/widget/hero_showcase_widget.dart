import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class HeroShowcaseWidget extends StatelessWidget {
  const HeroShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return ShowcaseWidget(
      title: l10n.heroShowcaseTitle,
      content: l10n.heroShowcaseContent,
      builder: (context) {
        return Column(
          children: [
            Hero(
              tag: 'hero',
              child: CircleDashWidget(
                width: 120.ss(),
                height: 120.ss(),
              ),
            ),
            SizedBox(height: 30.ss()),
            ElevatedButton(
              onPressed: () {
                context.push(AppRouter.sampleHeroAnimation);
              },
              child: Text(l10n.heroShowcaseButtonText),
            ),
          ],
        );
      },
    );
  }
}
