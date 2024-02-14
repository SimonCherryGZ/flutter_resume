import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/color_match/color_match.dart';

class ColorMatchCommonWidget<A extends Bloc<ColorMatchCommonEvent, B>,
    B extends ColorMatchCommonState> extends StatelessWidget {
  const ColorMatchCommonWidget({
    super.key,
    required this.title,
    required this.blocBuilder,
    required this.gameSceneBuilder,
    this.onStartGame,
  });

  final String title;
  final A Function(BuildContext context) blocBuilder;
  final WidgetBuilder gameSceneBuilder;
  final void Function(BuildContext context)? onStartGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocProvider(
        create: (context) => blocBuilder(context),
        child: BlocBuilder<A, B>(
          buildWhen: (p, c) {
            return p.status != c.status;
          },
          builder: (context, state) {
            final status = state.status;
            switch (status) {
              case GameStatus.prepare:
                return ColorMatchStartWidget(
                  onTap: () {
                    onStartGame?.call(context);
                  },
                );
              case GameStatus.playing:
                return gameSceneBuilder.call(context);
              case GameStatus.end:
                return ColorMatchEndWidget(
                  score: state.score,
                  onTap: () {
                    onStartGame?.call(context);
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
