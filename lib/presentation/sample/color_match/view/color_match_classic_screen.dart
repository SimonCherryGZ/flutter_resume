import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/bloc/color_match_classic_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/color_match.dart';
import 'package:flutter_resume/utils/utils.dart';

class ColorMatchClassicScreen extends StatelessWidget {
  const ColorMatchClassicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorMatchCommonWidget(
      title: '经典',
      blocBuilder: (context) => ColorMatchClassicBloc(),
      gameSceneBuilder: (context) => _GameScene(),
      onStartGame: (context) {
        ColorMatchClassicBloc.of(context).add(NextColor());
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
          BlocBuilder<ColorMatchClassicBloc, ColorMatchCommonState>(
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
          Stack(
            alignment: Alignment.center,
            children: [
              BlocBuilder<ColorMatchClassicBloc, ColorMatchCommonState>(
                buildWhen: (p, c) {
                  return p != c;
                },
                builder: (context, state) {
                  return Text(
                    state.trueColor.name,
                    style: TextStyle(
                      color: state.showColor.color,
                      fontSize: 20.ss(),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 200.ss(),
                height: 200.ss(),
                child:
                    BlocBuilder<ColorMatchClassicBloc, ColorMatchCommonState>(
                  buildWhen: (p, c) {
                    return p != c;
                  },
                  builder: (context, state) {
                    final color = state.showColor.color;
                    final percent = state.percent;
                    return CustomPaint(
                      size: Size.square(200.ss()),
                      painter: ColorArcPainter(_colorArcPainterData(
                        color,
                        percent,
                      )),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorMatchActionButton(
                onTap: () {
                  ColorMatchClassicBloc.of(context).add(SubmitAnswer(false));
                },
                color: Colors.blue,
                iconData: Icons.close,
              ),
              SizedBox(width: 100.ss()),
              ColorMatchActionButton(
                onTap: () {
                  ColorMatchClassicBloc.of(context).add(SubmitAnswer(true));
                },
                color: Colors.red,
                iconData: Icons.done,
              ),
            ],
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
