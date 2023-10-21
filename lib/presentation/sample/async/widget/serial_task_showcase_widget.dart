import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:oktoast/oktoast.dart';

class SerialTaskShowcaseWidget extends StatefulWidget {
  const SerialTaskShowcaseWidget({super.key});

  @override
  State<SerialTaskShowcaseWidget> createState() =>
      _SerialTaskShowcaseWidgetState();
}

class _SerialTaskShowcaseWidgetState extends State<SerialTaskShowcaseWidget> {
  bool _showSimulation = false;

  @override
  Widget build(BuildContext context) {
    const code = ''
        'Stopwatch stopwatch = Stopwatch();\n'
        'stopwatch.start();\n'
        'await Future.delayed(const Duration(milliseconds:200));\n'
        'await Future.delayed(const Duration(milliseconds:400));\n'
        'await Future.delayed(const Duration(milliseconds:600));\n'
        'final cost = stopwatch.elapsedMilliseconds;\n';
    return ShowcaseWidget(
      title: '演示多个异步任务阻塞等待',
      content: '总耗时等于全部异步任务耗时的总和',
      builder: (context) {
        return Column(
          children: [
            IndexedStack(
              alignment: Alignment.center,
              index: _showSimulation ? 1 : 0,
              children: [
                SyntaxView(
                  code: code,
                  syntax: Syntax.DART,
                  syntaxTheme: SyntaxTheme.dracula(),
                  fontSize: 10,
                  withZoom: false,
                  withLinesCount: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.ss()),
                  child: TaskSimulationWidget(
                    key: UniqueKey(),
                    tasks: [
                      Task(durationInMs: 200, delayInMs: 0),
                      Task(durationInMs: 400, delayInMs: 200),
                      Task(durationInMs: 600, delayInMs: 400),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.ss()),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showSimulation = !_showSimulation;
                  if (_showSimulation) {
                    _calculateTimeCost();
                  }
                });
              },
              child: Text(_showSimulation ? '返回' : '计算耗时'),
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
    await Future.delayed(const Duration(milliseconds: 200));
    await Future.delayed(const Duration(milliseconds: 400));
    await Future.delayed(const Duration(milliseconds: 600));
    final cost = stopwatch.elapsedMilliseconds;
    showToast('Time cost: $cost ms');
  }
}
