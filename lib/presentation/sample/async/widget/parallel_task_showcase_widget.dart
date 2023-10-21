import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:oktoast/oktoast.dart';

class ParallelTaskShowcaseWidget extends StatelessWidget {
  const ParallelTaskShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const code = ''
        'Stopwatch stopwatch = Stopwatch();\n'
        'stopwatch.start();\n'
        'await Future.wait([\n'
        '    Future.delayed(const Duration(milliseconds:100)),\n'
        '    Future.delayed(const Duration(milliseconds:200)),\n'
        '    Future.delayed(const Duration(milliseconds:300)),\n'
        ']);'
        'final cost = stopwatch.elapsedMilliseconds;\n';
    return ShowcaseWidget(
      title: '演示多个异步任务并行处理',
      content: '总耗时等于最长的耗时',
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
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 100)),
      Future.delayed(const Duration(milliseconds: 200)),
      Future.delayed(const Duration(milliseconds: 300)),
    ]);
    final cost = stopwatch.elapsedMilliseconds;
    showToast('Time cost: $cost ms');
  }
}
