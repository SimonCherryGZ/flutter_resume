import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class GlobalKeyShowcaseWidget extends StatelessWidget {
  const GlobalKeyShowcaseWidget({
    super.key,
    required this.globalKey,
  });

  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'GlobalKey',
      content: '在新页面通过 GlobalKey 访问此 Widget',
      builder: (context) {
        return Column(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: _ComplexWidget(),
            ),
            SizedBox(height: 30.ss()),
            ElevatedButton(
              onPressed: () {
                context.push(
                  AppRouter.sampleGlobalKeyAccess,
                  extra: globalKey,
                );
              },
              child: const Text('跳转新页面'),
            ),
          ],
        );
      },
    );
  }
}

class _ComplexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200.ss(),
          height: 200.ss(),
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.cyan,
                Colors.blue,
                Colors.purple,
              ],
            ),
          ),
        ),
        Icon(
          Icons.flutter_dash,
          size: 100.ss(),
        ),
        const Text(
          'Dash',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontStyle: FontStyle.italic,
            shadows: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 5,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
