part of 'pathfinding_bloc.dart';

class PathfindingState {
  final List<List<GridNode>> grid;
  final GridNode? start;
  final GridNode? end;

  PathfindingState({
    this.grid = const [],
    this.start,
    this.end,
  });

  PathfindingState copyWith({
    List<List<GridNode>>? grid,
    GridNode? start,
    GridNode? end,
  }) {
    return PathfindingState(
      grid: grid ?? this.grid,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
