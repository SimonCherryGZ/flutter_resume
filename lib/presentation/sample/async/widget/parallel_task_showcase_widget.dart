import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:oktoast/oktoast.dart';

class ParallelTaskShowcaseWidget extends StatefulWidget {
  const ParallelTaskShowcaseWidget({super.key});

  @override
  State<ParallelTaskShowcaseWidget> createState() =>
      _ParallelTaskShowcaseWidgetState();
}

class _ParallelTaskShowcaseWidgetState
    extends State<ParallelTaskShowcaseWidget> {
  bool _showSimulation = false;

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    const code = ''
        'Stopwatch stopwatch = Stopwatch();\n'
        'stopwatch.start();\n'
        'await Future.wait([\n'
        '    Future.delayed(const Duration(milliseconds:200)),\n'
        '    Future.delayed(const Duration(milliseconds:400)),\n'
        '    Future.delayed(const Duration(milliseconds:600)),\n'
        ']);\n'
        'final cost = stopwatch.elapsedMilliseconds;\n';
    return ShowcaseWidget(
      title: l10n.parallelTaskShowcaseTitle,
      content: l10n.parallelTaskShowcaseContent,
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
                      Task(durationInMs: 400, delayInMs: 0),
                      Task(durationInMs: 600, delayInMs: 0),
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
              child: Text(
                _showSimulation
                    ? l10n.parallelTaskShowcaseButtonText2
                    : l10n.parallelTaskShowcaseButtonText,
              ),
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
      Future.delayed(const Duration(milliseconds: 200)),
      Future.delayed(const Duration(milliseconds: 400)),
      Future.delayed(const Duration(milliseconds: 600)),
    ]);
    final cost = stopwatch.elapsedMilliseconds;
    showToast('Time cost: $cost ms');
  }
}
