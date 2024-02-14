import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/bloc/color_match_race_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/color_match.dart';
import 'package:flutter_resume/utils/utils.dart';

class ColorMatchRaceScreen extends StatelessWidget {
  const ColorMatchRaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorMatchCommonWidget(
      title: '极速',
      blocBuilder: (context) => ColorMatchRaceBloc(),
      gameSceneBuilder: (context) => _GameScene(),
      onStartGame: (context) {
        ColorMatchRaceBloc.of(context).add(NextColor());
      },
    );
  }
}

class _GameScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocBuilder<ColorMatchRaceBloc, ColorMatchRaceState>(
            buildWhen: (p, c) {
              return p.score != c.score;
            },
            builder: (context, state) {
              return Text(
                'Score: ${state.score}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.ss(),
                ),
              );
            },
          ),
          BlocBuilder<ColorMatchRaceBloc, ColorMatchRaceState>(
            buildWhen: (p, c) {
              return !listEquals(p.showColorList, c.showColorList);
            },
            builder: (context, state) {
              final showColorList = state.showColorList;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: showColorList.sublist(0, 2).map<Widget>((e) {
                      return _ColorRing(
                        textColor: e.first,
                        showColor: e.second,
                      );
                    }).toList()
                      ..insert(1, SizedBox(width: 30.ss())),
                  ),
                  SizedBox(height: 30.ss()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: showColorList.sublist(2, 4).map<Widget>((e) {
                      return _ColorRing(
                        textColor: e.first,
                        showColor: e.second,
                      );
                    }).toList()
                      ..insert(1, SizedBox(width: 30.ss())),
                  ),
                ],
              );
            },
          ),
          BlocBuilder<ColorMatchRaceBloc, ColorMatchRaceState>(
            buildWhen: (p, c) {
              return p.percent != c.percent;
            },
            builder: (context, state) {
              return SizedBox(
                width: 250.ss(),
                height: 30.ss(),
                child: CustomPaint(
                  size: Size(250.ss(), 30.ss()),
                  painter: _StatusBarPainter(state.percent),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ColorRing extends StatelessWidget {
  final ColorType textColor;
  final ColorType showColor;

  const _ColorRing({
    Key? key,
    required this.textColor,
    required this.showColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ColorMatchRaceBloc.of(context).add(SubmitAnswer(showColor));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            textColor.name,
            style: TextStyle(
              color: showColor.color,
              fontSize: 20.ss(),
            ),
          ),
          SizedBox(
            width: 120.ss(),
            height: 120.ss(),
            child: CustomPaint(
              size: Size.square(120.ss()),
              painter: ColorArcPainter(
                _colorArcPainterData(
                  showColor.color,
                  100.ss(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ColorArcPainterData _colorArcPainterData(
    final Color color,
    final double percent,
  ) {
    return ColorArcPainterData(
      startType: 2,
      lineColor: color,
      lineWidth: 10.ss(),
      percent: percent,
    );
  }
}

class _StatusBarPainter extends CustomPainter {
  final double progress;

  _StatusBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.grey.shade400;
    final rect1 = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect1, paint);

    paint.color = Colors.black45;
    final factor = (progress / 100.0);
    final rect2 = Rect.fromLTWH(0, 0, size.width * factor, size.height);
    canvas.drawRect(rect2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is! _StatusBarPainter) {
      return false;
    }
    return oldDelegate.progress != progress;
  }
}
