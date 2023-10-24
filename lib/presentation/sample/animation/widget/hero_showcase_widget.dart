import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class HeroShowcaseWidget extends StatelessWidget {
  const HeroShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'Hero',
      content: '演示共享元素动画',
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
              child: const Text('跳转新页面'),
            ),
          ],
        );
      },
    );
  }
}
