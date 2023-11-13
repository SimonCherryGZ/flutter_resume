import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

const width = 200.0;
const height = 300.0;

class RepaintBoundaryShowcaseWidget extends StatefulWidget {
  const RepaintBoundaryShowcaseWidget({
    super.key,
    required this.repaintBoundaryEnable,
    this.onPanDown,
    this.onPanEnd,
  });

  final bool repaintBoundaryEnable;
  final VoidCallback? onPanDown;
  final VoidCallback? onPanEnd;

  @override
  State<RepaintBoundaryShowcaseWidget> createState() =>
      _RepaintBoundaryShowcaseWidgetState();
}

class _RepaintBoundaryShowcaseWidgetState
    extends State<RepaintBoundaryShowcaseWidget> {
  late final ValueNotifier<Offset> _position;

  @override
  void initState() {
    super.initState();
    _position = ValueNotifier(const Offset(width / 2, height / 2));
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget expensivePainter = CustomPaint(
      size: const Size(width, height),
      painter: ExpensivePainter(),
      isComplex: true,
      willChange: false,
    );
    if (widget.repaintBoundaryEnable) {
      expensivePainter = RepaintBoundary(
        child: expensivePainter,
      );
    }
    return ShowcaseWidget(
      title: '${widget.repaintBoundaryEnable ? '有' : '无'} RepaintBoundary',
      content: widget.repaintBoundaryEnable
          ? '通过 RepaintBoundary 将其隔离\n避免与其它绘制操作共享 Layer'
          : '背景期望只绘制一次（shouldRepaint => false）\n但却随着黑色圆点的刷新而重绘',
      builder: (context) {
        return Column(
          children: [
            PerformanceOverlay.allEnabled(),
            const SizedBox(height: 50),
            SizedBox(
              width: width,
              height: height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  expensivePainter,
                  GestureDetector(
                    onPanDown: (_) {
                      widget.onPanDown?.call();
                    },
                    onPanUpdate: (details) {
                      _position.value = details.localPosition;
                    },
                    onPanEnd: (_) {
                      widget.onPanEnd?.call();
                    },
                    onPanCancel: () {
                      widget.onPanEnd?.call();
                    },
                    child: CustomPaint(
                      size: const Size(width, height),
                      painter: PointerPositionPainter(_position),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
