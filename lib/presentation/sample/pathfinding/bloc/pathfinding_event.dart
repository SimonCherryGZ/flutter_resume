part of 'pathfinding_bloc.dart';

abstract class PathfindingEvent {}

class InitGrid extends PathfindingEvent {}

class SetNodeAsStart extends PathfindingEvent {
  SetNodeAsStart(this.node);

  final GridNode node;
}

class SetNodeAsEnd extends PathfindingEvent {
  SetNodeAsEnd(this.node);

  final GridNode node;
}

class Pathfinding extends PathfindingEvent {
  Pathfinding(this.start, this.end);

  final GridNode start;
  final GridNode end;
}

class UpdateGrid extends PathfindingEvent {
  UpdateGrid(this.grid);

  final List<List<GridNode>> grid;
}
