import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class CurveShowcaseWidget extends StatefulWidget {
  const CurveShowcaseWidget({super.key});

  @override
  State<CurveShowcaseWidget> createState() => _CurveShowcaseWidgetState();
}

class _CurveShowcaseWidgetState extends State<CurveShowcaseWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<MapEntry<String, Curve>> _curveList = [
    const MapEntry('linear', Curves.linear),
    const MapEntry('slowMiddle', Curves.slowMiddle),
    const MapEntry('easeInOut', Curves.easeInOut),
    const MapEntry('easeInBack', Curves.easeInBack),
    const MapEntry('fastLinearToSlowEaseIn', Curves.fastLinearToSlowEaseIn),
    const MapEntry('bounceInOut', Curves.bounceInOut),
    const MapEntry('elasticInOut', Curves.elasticInOut),
  ];
  late final ValueNotifier<MapEntry<String, Curve>> _curveNotifier;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _curveNotifier = ValueNotifier(_curveList[0]);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _curveNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'Curve',
      content: '演示动画曲线',
      builder: (context) {
        const gridPaperSize = 200.0;
        const ballSize = 15.0;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: gridPaperSize,
                  height: gridPaperSize,
                  child: GridPaper(
                    color: Colors.black.withOpacity(0.5),
                    divisions: 1,
                    subdivisions: 5,
                    child: ValueListenableBuilder(
                      valueListenable: _curveNotifier,
                      builder: (context, map, child) {
                        return CustomPaint(
                          painter: DrawCurvePainter(
                            curve: map.value,
                            progress: _controller.view,
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 30.ss()),
                AnimatedBuilder(
                  animation: _controller.view,
                  builder: (context, child) {
                    final offsetY = _curveNotifier.value.value
                                .transform(_controller.value) *
                            gridPaperSize -
                        (ballSize / 2);
                    return Transform.translate(
                      offset: Offset(0, -offsetY),
                      child: child,
                    );
                  },
                  child: Container(
                    width: ballSize,
                    height: ballSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70.ss(),
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: _curveNotifier,
                  builder: (context, map, child) {
                    return Text(map.key);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40.ss(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.ss()),
                itemCount: _curveList.length,
                itemBuilder: (context, index) {
                  final map = _curveList[index];
                  return ElevatedButton(
                    onPressed: () {
                      _curveNotifier.value = map;
                      _controller.reset();
                      _controller.forward();
                    },
                    child: Text(map.key),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 20.ss());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
