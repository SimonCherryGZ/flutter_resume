import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/neon_shooter_game.dart';
import '../ui/game_over_overlay.dart';

class FlameNeonShooterPage extends StatefulWidget {
  const FlameNeonShooterPage({super.key});

  @override
  State<FlameNeonShooterPage> createState() => _FlameNeonShooterPageState();
}

class _FlameNeonShooterPageState extends State<FlameNeonShooterPage> {
  late NeonShooterGame game;

  @override
  void initState() {
    super.initState();
    game = NeonShooterGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onPanUpdate: (details) {
          game.movePlayer(details.delta);
        },
        child: GameWidget<NeonShooterGame>.controlled(
          gameFactory: () => game,
          overlayBuilderMap: {
            'GameOver': (BuildContext context, NeonShooterGame game) {
              return GameOverOverlay(game: game);
            },
          },
        ),
      ),
    );
  }
}
