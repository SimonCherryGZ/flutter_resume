import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class SubRoutesShowcaseWidget extends StatelessWidget {
  const SubRoutesShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'GoRouter Sub-routes',
      content: '存在两组子路由：\n(1) Root -> A -> B -> C -> D\n(2) Root -> C -> D\n演示如何复用 C -> D',
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppRouter.sampleSubRouteA);
              },
              child: const Text('跳转 A 页面'),
            ),
            SizedBox(height: 10.ss()),
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppRouter.sampleSubRouteC_2);
              },
              child: const Text('跳转 C 页面'),
            ),
          ],
        );
      },
    );
  }
}
