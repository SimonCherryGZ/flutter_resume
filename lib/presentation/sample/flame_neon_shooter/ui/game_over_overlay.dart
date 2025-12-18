import 'dart:async';
import 'package:flutter/material.dart';
import '../game/neon_shooter_game.dart';

class GameOverOverlay extends StatelessWidget {
  final NeonShooterGame game;

  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    // Use StreamBuilder to listen to game state changes
    return StreamBuilder<void>(
      stream: Stream.periodic(const Duration(milliseconds: 100)),
      builder: (context, snapshot) {
        if (game.status != NeonShooterGameStatus.gameOver) {
          return const SizedBox.shrink();
        }

        return Container(
          color: Colors.black54,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'GAME OVER',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.redAccent, blurRadius: 20)],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Final Score: ${game.player?.entity.score ?? 0}',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  onPressed: () {
                    game.restart();
                  },
                  child: const Text('RESTART', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
