import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class RemoveConstraintsShowcaseWidget extends StatelessWidget {
  const RemoveConstraintsShowcaseWidget({
    super.key,
    required this.boxSize,
  });

  final double boxSize;

  @override
  Widget build(BuildContext context) {
    const containerSize = 250.0;
    final code = ''
        'Container(\n'
        '  color: Colors.red,\n'
        '  width: $containerSize,\n'
        '  height: $containerSize,\n'
        '  child: const UnconstrainedBox(\n'
        '    child: ConstraintsLabelBox(\n'
        '      color: Colors.blue,\n'
        '      width: $boxSize,\n'
        '      height: $boxSize,\n'
        '    ),\n'
        '  ),\n'
        '),';
    final isOverflow = boxSize > containerSize;
    return ShowcaseWidget(
      title: '去除父约束',
      content: isOverflow ? '但是要小心，太过自由的话...' : '蓝色盒自由了',
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
                  child: UnconstrainedBox(
                    child: ConstraintsLabelBox(
                      color: Colors.blue,
                      width: boxSize,
                      height: boxSize,
                    ),
                  ),
                ),
                if (!isOverflow) ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'w=$containerSize, h=$containerSize',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                if (isOverflow) ...[
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
              ],
            ),
          ],
        );
      },
    );
  }
}
