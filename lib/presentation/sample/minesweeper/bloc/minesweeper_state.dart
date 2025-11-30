part of 'minesweeper_bloc.dart';

enum MineSweeperGameStatus { playing, won, lost }

class MinesweeperState {
  final List<List<Cell>> board;
  final MineSweeperGameStatus status;
  final int mineCount;
  final int flagCount;
  final int timer;

  MinesweeperState({
    required this.board,
    required this.status,
    required this.mineCount,
    required this.flagCount,
    required this.timer,
  });

  factory MinesweeperState.initial() {
    return MinesweeperState(
      board: [],
      status: MineSweeperGameStatus.playing,
      mineCount: 0,
      flagCount: 0,
      timer: 0,
    );
  }

  MinesweeperState copyWith({
    List<List<Cell>>? board,
    MineSweeperGameStatus? status,
    int? mineCount,
    int? flagCount,
    int? timer,
  }) {
    return MinesweeperState(
      board: board ?? this.board,
      status: status ?? this.status,
      mineCount: mineCount ?? this.mineCount,
      flagCount: flagCount ?? this.flagCount,
      timer: timer ?? this.timer,
    );
  }
}

class Cell {
  final int x;
  final int y;
  final bool isMine;
  final bool isRevealed;
  final bool isFlagged;
  final int adjacentMines;

  Cell({
    required this.x,
    required this.y,
    required this.isMine,
    this.isRevealed = false,
    this.isFlagged = false,
    this.adjacentMines = 0,
  });

  Cell copyWith({
    bool? isRevealed,
    bool? isFlagged,
  }) {
    return Cell(
      x: x,
      y: y,
      isMine: isMine,
      isRevealed: isRevealed ?? this.isRevealed,
      isFlagged: isFlagged ?? this.isFlagged,
      adjacentMines: adjacentMines,
    );
  }
}
