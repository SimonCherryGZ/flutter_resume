import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class FixConstraintsProblemShowcaseWidget extends StatelessWidget {
  const FixConstraintsProblemShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const containerSize = 250.0;
    const boxSize = 250.0;
    const constraintSize = 150.0;
    const code = ''
        'Container(\n'
        '  color: Colors.red,\n'
        '  width: $containerSize,\n'
        '  height: $containerSize,\n'
        '  child: const Center(\n'
        '    child: ConstrainedBox(\n'
        '      constraints:\n'
        '          BoxConstraints.loose(const Size($constraintSize, $constraintSize)),\n'
        '      child: ConstraintsLabelBox(\n'
        '        color: Colors.blue,\n'
        '        width: $boxSize,\n'
        '        height: $boxSize,\n'
        '      ),\n'
        '    ),\n'
        '  ),\n'
        '),';
    return ShowcaseWidget(
      title: '把父约束改成 Loose 约束',
      content: 'ConstrainedBox 额外约束得以体现',
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
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.loose(
                          const Size(constraintSize, constraintSize)),
                      child: const ConstraintsLabelBox(
                        color: Colors.blue,
                        width: boxSize,
                        height: boxSize,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'w=$containerSize, h=$containerSize',
                    style: TextStyle(color: Colors.white),
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
