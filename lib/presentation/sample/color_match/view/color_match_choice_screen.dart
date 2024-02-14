import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/bloc/color_match_choice_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/color_match.dart';
import 'package:flutter_resume/utils/utils.dart';

class ColorMatchChoiceScreen extends StatelessWidget {
  const ColorMatchChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorMatchCommonWidget(
      title: '多选一',
      blocBuilder: (context) => ColorMatchChoiceBloc(),
      gameSceneBuilder: (context) => _GameScene(),
      onStartGame: (context) {
        ColorMatchChoiceBloc.of(context).add(NextColor());
      },
    );
  }
}

class _GameScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenH = screenSize.height;
    final gridH = screenH * 0.2;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocBuilder<ColorMatchChoiceBloc, ColorMatchCommonState>(
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
              BlocBuilder<ColorMatchChoiceBloc, ColorMatchCommonState>(
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
                child: BlocBuilder<ColorMatchChoiceBloc, ColorMatchCommonState>(
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
          Container(
            height: gridH,
            padding: EdgeInsets.symmetric(horizontal: 50.ss()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ColorType.values.sublist(0, 4).map((e) {
                    return _ColorItem(colorType: e);
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ColorType.values.sublist(4, 8).map((e) {
                    return _ColorItem(colorType: e);
                  }).toList(),
                ),
              ],
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

class _ColorItem extends StatelessWidget {
  final ColorType colorType;

  const _ColorItem({Key? key, required this.colorType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenH = screenSize.height;
    final itemH = screenH * 0.1 * 0.7;
    return GestureDetector(
      onTap: () {
        ColorMatchChoiceBloc.of(context).add(SubmitAnswer(colorType));
      },
      child: Container(
        width: itemH,
        height: itemH,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(itemH),
          border: Border.all(
            color: colorType.color,
            width: 5.ss(),
          ),
        ),
      ),
    );
  }
}
