import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'minesweeper_event.dart';
part 'minesweeper_state.dart';

class MinesweeperBloc extends Bloc<MinesweeperEvent, MinesweeperState> {
  MinesweeperBloc() : super(MinesweeperState.initial()) {
    on<MinesweeperInitEvent>(_onInit);
    on<MinesweeperRevealEvent>(_onReveal);
    on<MinesweeperFlagEvent>(_onFlag);
  }

  static const int rows = 10;
  static const int cols = 10;
  static const int totalMines = 15;

  void _onInit(MinesweeperInitEvent event, Emitter<MinesweeperState> emit) {
    final board = _generateBoard();
    emit(state.copyWith(
      board: board,
      status: MineSweeperGameStatus.playing,
      mineCount: totalMines,
      flagCount: 0,
      timer: 0,
    ));
  }

  void _onReveal(MinesweeperRevealEvent event, Emitter<MinesweeperState> emit) {
    if (state.status != MineSweeperGameStatus.playing) return;
    
    var board = List<List<Cell>>.from(state.board.map((row) => List<Cell>.from(row)));
    final cell = board[event.y][event.x];

    if (cell.isFlagged || cell.isRevealed) return;

    if (cell.isMine) {
      // Game Over
      board = _revealAllMines(board);
      emit(state.copyWith(board: board, status: MineSweeperGameStatus.lost));
    } else {
      _revealCell(board, event.x, event.y);
      if (_checkWin(board)) {
        emit(state.copyWith(board: board, status: MineSweeperGameStatus.won));
      } else {
        emit(state.copyWith(board: board));
      }
    }
  }

  void _onFlag(MinesweeperFlagEvent event, Emitter<MinesweeperState> emit) {
    if (state.status != MineSweeperGameStatus.playing) return;

    final board = List<List<Cell>>.from(state.board.map((row) => List<Cell>.from(row)));
    final cell = board[event.y][event.x];

    if (cell.isRevealed) return;

    board[event.y][event.x] = cell.copyWith(isFlagged: !cell.isFlagged);
    
    int flagCount = state.flagCount + (board[event.y][event.x].isFlagged ? 1 : -1);

    emit(state.copyWith(board: board, flagCount: flagCount));
  }

  List<List<Cell>> _generateBoard() {
    // Initialize empty board
    List<List<Cell>> board = List.generate(rows, (y) {
      return List.generate(cols, (x) {
        return Cell(x: x, y: y, isMine: false);
      });
    });

    // Place mines
    int minesPlaced = 0;
    final random = Random();
    while (minesPlaced < totalMines) {
      int x = random.nextInt(cols);
      int y = random.nextInt(rows);
      if (!board[y][x].isMine) {
        board[y][x] = Cell(x: x, y: y, isMine: true);
        minesPlaced++;
      }
    }

    // Calculate adjacent mines
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if (!board[y][x].isMine) {
          int count = 0;
          for (int dy = -1; dy <= 1; dy++) {
            for (int dx = -1; dx <= 1; dx++) {
              int ny = y + dy;
              int nx = x + dx;
              if (ny >= 0 && ny < rows && nx >= 0 && nx < cols && board[ny][nx].isMine) {
                count++;
              }
            }
          }
          board[y][x] = Cell(x: x, y: y, isMine: false, adjacentMines: count);
        }
      }
    }

    return board;
  }

  void _revealCell(List<List<Cell>> board, int x, int y) {
    if (x < 0 || x >= cols || y < 0 || y >= rows || board[y][x].isRevealed || board[y][x].isFlagged) {
      return;
    }

    board[y][x] = board[y][x].copyWith(isRevealed: true);

    if (board[y][x].adjacentMines == 0) {
      for (int dy = -1; dy <= 1; dy++) {
        for (int dx = -1; dx <= 1; dx++) {
          if (dx != 0 || dy != 0) {
            _revealCell(board, x + dx, y + dy);
          }
        }
      }
    }
  }

  List<List<Cell>> _revealAllMines(List<List<Cell>> board) {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if (board[y][x].isMine) {
          board[y][x] = board[y][x].copyWith(isRevealed: true);
        }
      }
    }
    return board;
  }

  bool _checkWin(List<List<Cell>> board) {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if (!board[y][x].isMine && !board[y][x].isRevealed) {
          return false;
        }
      }
    }
    return true;
  }
}
