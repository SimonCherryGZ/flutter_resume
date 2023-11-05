import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class FixSizeProblemShowcaseWidget extends StatelessWidget {
  const FixSizeProblemShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const containerSize = 250.0;
    const boxSize = 150.0;
    const code = ''
        'Container(\n'
        '  color: Colors.red,\n'
        '  width: $containerSize,\n'
        '  height: $containerSize,\n'
        '  child: const Center(\n'
        '    child: ConstraintsLabelBox(\n'
        '        color: Colors.blue,\n'
        '        width: $boxSize,\n'
        '        height: $boxSize,\n'
        '    ),\n'
        '  ),\n'
        '),';
    return ShowcaseWidget(
      title: '套一层 Center',
      content: '把红色盒的 Tight 约束转为 Loose 约束\n（* 实际是 RenderPositionedBox 改的）',
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
                  child: const Center(
                    child: ConstraintsLabelBox(
                      color: Colors.blue,
                      width: boxSize,
                      height: boxSize,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'w=250, h=250',
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
