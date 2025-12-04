import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/neon_shooter_bloc.dart';
import 'neon_painter.dart';

class NeonShooterPage extends StatelessWidget {
  const NeonShooterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => NeonShooterBloc()..add(NeonShooterInitEvent()),
        child: const _NeonShooterView(),
      ),
    );
  }
}

class _NeonShooterView extends StatelessWidget {
  const _NeonShooterView();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        context.read<NeonShooterBloc>().add(
          NeonShooterResizeEvent(Size(constraints.maxWidth, constraints.maxHeight))
        );

        return Stack(
          children: [
            // Game Layer
            GestureDetector(
              onPanUpdate: (details) {
                context.read<NeonShooterBloc>().add(NeonShooterMovePlayerEvent(details.delta));
              },
              child: BlocBuilder<NeonShooterBloc, NeonShooterState>(
                builder: (context, state) {
                  return CustomPaint(
                    painter: NeonPainter(state),
                    size: Size.infinite,
                  );
                },
              ),
            ),

            // HUD Layer
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<NeonShooterBloc, NeonShooterState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SCORE: ${state.player.score}',
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
                            Expanded(
                              child: LinearProgressIndicator(
                                value: state.player.hp / state.player.maxHp,
                                backgroundColor: Colors.grey[800],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  state.player.hp > 30 ? Colors.green : Colors.red
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'WAVE: ${state.wave}',
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Game Over Overlay
            BlocBuilder<NeonShooterBloc, NeonShooterState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                if (state.status == NeonShooterStatus.gameOver) {
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
                            'Final Score: ${state.player.score}',
                            style: const TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            ),
                            onPressed: () {
                              context.read<NeonShooterBloc>().add(NeonShooterRestartEvent());
                            },
                            child: const Text('RESTART', style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
