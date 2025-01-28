import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleNumberSpinnerScreen extends StatelessWidget {
  const SampleNumberSpinnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Spinner'),
      ),
      body: _SampleNumberSpinnerScreenContent(),
    );
  }
}

class _SampleNumberSpinnerScreenContent extends StatefulWidget {
  @override
  State<_SampleNumberSpinnerScreenContent> createState() =>
      _SampleNumberSpinnerScreenContentState();
}

class _SampleNumberSpinnerScreenContentState
    extends State<_SampleNumberSpinnerScreenContent> {
  final _numberSpinnerController = NumberSpinnerController();
  bool _playing = false;
  int _targetNumber = 777;
  late final Random _random;

  @override
  void initState() {
    super.initState();
    _random = Random();
  }

  @override
  Widget build(BuildContext context) {
    const fontSize = 60.0;
    const numberTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      height: 1,
      color: Colors.white,
      shadows: [
        Shadow(
          offset: Offset.zero,
          blurRadius: 10,
          color: Colors.black,
        ),
      ],
    );
    const frameWidth = 250.0;
    const frameFillColor = Colors.black12;
    const frameBorderColor = Colors.grey;
    const frameBorderWidth = 2.0;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: frameWidth - 47,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border.all(
                color: frameBorderColor,
                width: frameBorderWidth,
              ),
            ),
            child: const Center(
              child: Text(
                'JACKPOT',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Color(0xFFF8FF20),
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 10),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: frameFillColor,
              border: Border.all(
                color: frameBorderColor,
                width: frameBorderWidth,
              ),
            ),
            child: _NumberSpinnerWidget(
              targetNumber: _targetNumber,
              numberTextStyle: numberTextStyle,
              controller: _numberSpinnerController,
              onCompleted: () {
                setState(() {
                  _playing = false;
                });
              },
            ),
          ),
          SizedBox(
            width: frameWidth,
            height: 80,
            child: CustomPaint(
              painter: _TrapezoidPainter(
                fillColor: frameFillColor,
                borderColor: frameBorderColor,
                borderWidth: frameBorderWidth,
              ),
              child: _ButtonGroup(
                enable: !_playing,
                onSpin: () {
                  setState(() {
                    _playing = true;
                    _numberSpinnerController.reset();

                    _targetNumber = _random.nextInt(899) + 100;
                    Future.delayed(const Duration(milliseconds: 300)).then((_) {
                      if (mounted) {
                        _numberSpinnerController.forward();
                      }
                    });
                  });
                },
                onReset: () {
                  _numberSpinnerController.reset();
                },
              ),
            ),
          ),
          Container(
            width: frameWidth + 2,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                color: frameBorderColor,
                width: frameBorderWidth,
              ),
            ),
            child: Column(
              children: [
                Transform.translate(
                  offset: const Offset(0, 190),
                  child: const _ArcText(
                    'LUCKY SLOT',
                    startAngle: -21 * pi / 180,
                    radius: 150,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 10,
                        ),
                        Shadow(
                          color: Color(0xFFF8FF20),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberSpinnerWidget extends StatelessWidget {
  const _NumberSpinnerWidget({
    required this.targetNumber,
    required this.numberTextStyle,
    this.controller,
    this.onCompleted,
  });

  final int targetNumber;
  final TextStyle numberTextStyle;
  final NumberSpinnerController? controller;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    final unitWidth = (numberTextStyle.fontSize ?? 0) * 0.65 + 10;
    final unitHeight =
        (numberTextStyle.fontSize ?? 0) * (numberTextStyle.height ?? 0) + 20;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: NumberSpinner(
        targetNumber: targetNumber,
        showAnimation: true,
        controller: controller,
        unitWidth: unitWidth,
        unitHeight: unitHeight,
        duration: const Duration(milliseconds: 1500),
        delayBetween: const Duration(milliseconds: 200),
        numberTextStyle: numberTextStyle,
        numberUnitWidgetBuilder: (context, text) {
          return Container(
            width: unitWidth,
            height: unitHeight,
            decoration: const BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: ShaderMask(
                shaderCallback: (rect) => const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.orange,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(rect),
                child: Text(
                  text,
                  style: numberTextStyle,
                ),
              ),
            ),
          );
        },
        onCompleted: onCompleted,
      ),
    );
  }
}

class _ButtonGroup extends StatelessWidget {
  const _ButtonGroup({
    required this.enable,
    this.onSpin,
    this.onReset,
  });

  final bool enable;
  final VoidCallback? onSpin;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: enable ? onSpin : null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Theme.of(context).disabledColor,
          ),
          child: const Text('Spin'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: enable ? onReset : null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Theme.of(context).disabledColor,
          ),
          child: const Text('Reset'),
        ),
      ],
    );
  }
}

class _TrapezoidPainter extends CustomPainter {
  _TrapezoidPainter({
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
  });

  final Color fillColor;
  final Color borderColor;
  final double borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    // 定义梯形的四个顶点
    final path = Path()
      ..moveTo(size.width * 0.1, 0) // 上边的左顶点
      ..lineTo(size.width * 0.9, 0) // 上边的右顶点
      ..lineTo(size.width, size.height) // 下边的右顶点
      ..lineTo(0, size.height) // 下边的左顶点
      ..close();

    canvas.drawPath(path, paint);

    paint.color = borderColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = borderWidth;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _ArcText extends StatelessWidget {
  const _ArcText(
    this.text, {
    required this.radius,
    required this.style,
    this.startAngle = 0,
  });

  final double radius;
  final String text;
  final double startAngle;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _ArcTextPainter(
          radius,
          text,
          style,
          initialAngle: startAngle,
        ),
      );
}

class _ArcTextPainter extends CustomPainter {
  _ArcTextPainter(
    this.radius,
    this.text,
    this.textStyle, {
    this.initialAngle = 0,
  });

  final num radius;
  final String text;
  final double initialAngle;
  final TextStyle textStyle;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2 - radius);

    if (initialAngle != 0) {
      final d = 2 * radius * sin(initialAngle / 2);
      final rotationAngle = _calculateRotationAngle(0, initialAngle);
      canvas.rotate(rotationAngle);
      canvas.translate(d, 0);
    }

    double angle = initialAngle;
    for (int i = 0; i < text.length; i++) {
      angle = _drawLetter(canvas, text[i], angle);
    }
  }

  double _drawLetter(Canvas canvas, String letter, double prevAngle) {
    _textPainter.text = TextSpan(text: letter, style: textStyle);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    final double d = _textPainter.width;
    final double alpha = 2 * asin(d / (2 * radius));

    final newAngle = _calculateRotationAngle(prevAngle, alpha);
    canvas.rotate(newAngle);

    _textPainter.paint(canvas, Offset(0, -_textPainter.height));
    canvas.translate(d, 0);

    return alpha;
  }

  double _calculateRotationAngle(double prevAngle, double alpha) =>
      (alpha + prevAngle) / 2;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
