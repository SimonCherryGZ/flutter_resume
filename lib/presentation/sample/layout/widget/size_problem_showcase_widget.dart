import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class SizeProblemShowcaseWidget extends StatelessWidget {
  const SizeProblemShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const containerSize = 250.0;
    const boxSize = 150.0;
    const code = ''
        'Container(\n'
        '  color: Colors.red,\n'
        '  width: $containerSize,\n'
        '  height: $containerSize,\n'
        '  child: const ConstraintsLabelBox(\n'
        '    color: Colors.blue,\n'
        '    width: $boxSize,\n'
        '    height: $boxSize,\n'
        '  ),\n'
        '),';
    return ShowcaseWidget(
      title: 'Container 宽高不生效',
      content: '红色盒给蓝色盒的是 Tight 约束',
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
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  color: Colors.red,
                  width: containerSize,
                  height: containerSize,
                  child: const ConstraintsLabelBox(
                    color: Colors.blue,
                    width: boxSize,
                    height: boxSize,
                  ),
                ),
                Container(
                  width: containerSize,
                  height: containerSize,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.5),
                      width: 4,
                    ),
                  ),
                ),
                Positioned(
                  left: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 4,
                      top: 2,
                      right: 4,
                      bottom: 4,
                    ),
                    color: Colors.red.withValues(alpha: 0.5),
                    child: const Text(
                      'w=$containerSize, h=$containerSize',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
