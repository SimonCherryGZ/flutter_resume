part of 'neon_shooter_bloc.dart';

enum NeonShooterStatus { initial, playing, gameOver }

class NeonShooterState {
  final NeonShooterStatus status;
  final Player player;
  final List<Enemy> enemies;
  final List<Bullet> bullets;
  final List<Item> items;
  final int wave;
  final Size screenSize;

  NeonShooterState({
    required this.status,
    required this.player,
    required this.enemies,
    required this.bullets,
    required this.items,
    required this.wave,
    required this.screenSize,
  });

  factory NeonShooterState.initial() {
    return NeonShooterState(
      status: NeonShooterStatus.initial,
      player: Player(
        position: const Offset(0, 0),
        size: const Size(40, 40),
        velocity: Offset.zero,
        color: const Color(0xFF00FFFF),
      ),
      enemies: [],
      bullets: [],
      items: [],
      wave: 1,
      screenSize: Size.zero,
    );
  }

  NeonShooterState copyWith({
    NeonShooterStatus? status,
    Player? player,
    List<Enemy>? enemies,
    List<Bullet>? bullets,
    List<Item>? items,
    int? wave,
    Size? screenSize,
  }) {
    return NeonShooterState(
      status: status ?? this.status,
      player: player ?? this.player,
      enemies: enemies ?? this.enemies,
      bullets: bullets ?? this.bullets,
      items: items ?? this.items,
      wave: wave ?? this.wave,
      screenSize: screenSize ?? this.screenSize,
    );
  }
}
