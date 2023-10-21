import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:oktoast/oktoast.dart';

class SerialTaskShowcaseWidget extends StatelessWidget {
  const SerialTaskShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const code = ''
        'Stopwatch stopwatch = Stopwatch();\n'
        'stopwatch.start();\n'
        'await Future.delayed(const Duration(milliseconds:100));\n'
        'await Future.delayed(const Duration(milliseconds:200));\n'
        'await Future.delayed(const Duration(milliseconds:300));\n'
        'final cost = stopwatch.elapsedMilliseconds;\n';
    return ShowcaseWidget(
      title: '演示多个异步任务阻塞等待',
      content: '总耗时等于全部异步任务耗时的总和',
      builder: (context) {
        return Column(
          children: [
            SyntaxView(
              code: code,
              syntax: Syntax.DART,
              syntaxTheme: SyntaxTheme.dracula(),
              fontSize: 10,
              withZoom: false,
              withLinesCount: false,
            ),
            SizedBox(height: 30.ss()),
            ElevatedButton(
              onPressed: () {
                _calculateTimeCost();
              },
              child: const Text('计算耗时'),
            ),
          ],
        );
      },
    );
  }

  void _calculateTimeCost() async {
    showToast('Calculating...');
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    await Future.delayed(const Duration(milliseconds: 100));
    await Future.delayed(const Duration(milliseconds: 200));
    await Future.delayed(const Duration(milliseconds: 300));
    final cost = stopwatch.elapsedMilliseconds;
    showToast('Time cost: $cost ms');
  }
}
