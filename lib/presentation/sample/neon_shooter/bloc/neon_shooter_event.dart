part of 'neon_shooter_bloc.dart';

abstract class NeonShooterEvent {}

class NeonShooterInitEvent extends NeonShooterEvent {}

class NeonShooterUpdateEvent extends NeonShooterEvent {}

class NeonShooterMovePlayerEvent extends NeonShooterEvent {
  final Offset delta;
  NeonShooterMovePlayerEvent(this.delta);
}

class NeonShooterRestartEvent extends NeonShooterEvent {}

class NeonShooterResizeEvent extends NeonShooterEvent {
  final Size size;
  NeonShooterResizeEvent(this.size);
}
