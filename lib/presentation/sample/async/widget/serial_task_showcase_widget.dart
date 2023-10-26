import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
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
    final l10n = L10nDelegate.l10n(context);
    const code = ''
        'Stopwatch stopwatch = Stopwatch();\n'
        'stopwatch.start();\n'
        'await Future.delayed(const Duration(milliseconds:200));\n'
        'await Future.delayed(const Duration(milliseconds:400));\n'
        'await Future.delayed(const Duration(milliseconds:600));\n'
        'final cost = stopwatch.elapsedMilliseconds;\n';
    return ShowcaseWidget(
      title: l10n.serialTaskShowcaseTitle,
      content: l10n.serialTaskShowcaseContent,
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
              child: Text(
                _showSimulation
                    ? l10n.serialTaskShowcaseButtonText2
                    : l10n.serialTaskShowcaseButtonText,
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
    await Future.delayed(const Duration(milliseconds: 200));
    await Future.delayed(const Duration(milliseconds: 400));
    await Future.delayed(const Duration(milliseconds: 600));
    final cost = stopwatch.elapsedMilliseconds;
    showToast('Time cost: $cost ms');
  }
}
