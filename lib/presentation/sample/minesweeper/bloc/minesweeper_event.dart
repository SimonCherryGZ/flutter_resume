part of 'minesweeper_bloc.dart';

abstract class MinesweeperEvent {}

class MinesweeperInitEvent extends MinesweeperEvent {}

class MinesweeperRevealEvent extends MinesweeperEvent {
  final int x;
  final int y;

  MinesweeperRevealEvent(this.x, this.y);
}

class MinesweeperFlagEvent extends MinesweeperEvent {
  final int x;
  final int y;

  MinesweeperFlagEvent(this.x, this.y);
}
