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
      body: Stack(
        children: [
          // Game widget
          GestureDetector(
            onPanUpdate: (details) {
              game.movePlayer(details.delta);
            },
            child: GameWidget<NeonShooterGame>.controlled(
              gameFactory: () => game,
            ),
          ),
          
          // HUD Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<void>(
                stream: Stream.periodic(const Duration(milliseconds: 16)),
                builder: (context, snapshot) {
                  if (game.player == null) {
                    return const SizedBox.shrink();
                  }
                  
                  final player = game.player!.entity;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SCORE: ${player.score}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(color: Colors.cyan, blurRadius: 10)],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'HP: ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            width: 100,
                            child: LinearProgressIndicator(
                              value: player.hp / player.maxHp,
                              backgroundColor: Colors.grey[800],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                player.hp > 30 ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'WAVE: ${game.wave}',
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          
          // Game Over Overlay
          GameOverOverlay(game: game),
        ],
      ),
    );
  }
}
