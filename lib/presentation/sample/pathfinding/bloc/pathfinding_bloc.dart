import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_resume/presentation/sample/pathfinding/entity/entity.dart';

part 'pathfinding_event.dart';

part 'pathfinding_state.dart';

const int kGridSize = 10;

typedef PathfindingDelegate = void Function(AStarNode node, GridNodeType type);

class PathfindingBloc extends Bloc<PathfindingEvent, PathfindingState> {
  PathfindingBloc() : super(PathfindingState()) {
    on<InitGrid>(_onInitGrid);
    on<SetNodeAsStart>(_onSetNodeAsStart);
    on<SetNodeAsEnd>(_onSetNodeAsEnd);
    on<Pathfinding>(_onPathfinding);
    on<UpdateGrid>(_onUpdateGrid);
  }

  final Random _random = Random();

  FutureOr<void> _onInitGrid(
    InitGrid event,
    Emitter<PathfindingState> emit,
  ) async {
    _clearPath();

    List<List<GridNode>> grid =
        List.generate(kGridSize, (_) => List.filled(kGridSize, GridNode()));
    for (int y = 0; y < kGridSize; y++) {
      for (int x = 0; x < kGridSize; x++) {
        bool isObstacle = _random.nextDouble() > 0.8;
        final node = GridNode();
        node.x = x;
        node.y = y;
        node.type = isObstacle ? GridNodeType.obstacle : GridNodeType.normal;
        grid[y][x] = node;
      }
    }
    emit(PathfindingState(grid: grid));
  }

  FutureOr<void> _onSetNodeAsStart(
    SetNodeAsStart event,
    Emitter<PathfindingState> emit,
  ) async {
    final node = event.node;
    if (node.type != GridNodeType.normal) {
      return;
    }
    final x = node.x;
    final y = node.y;
    final grid = state.grid;
    grid[y][x].type = GridNodeType.start;

    GridNode? start = state.start;
    if (start != null) {
      start.type = GridNodeType.normal;
    }
    start = grid[y][x];

    // 设置起点时，重置之前的路径
    _clearPath();
    emit(state.copyWith(start: start));
  }

  FutureOr<void> _onSetNodeAsEnd(
    SetNodeAsEnd event,
    Emitter<PathfindingState> emit,
  ) async {
    final node = event.node;
    if (node.type != GridNodeType.normal) {
      return;
    }
    final x = node.x;
    final y = node.y;
    final grid = state.grid;
    grid[y][x].type = GridNodeType.end;

    GridNode? end = state.end;
    if (end != null) {
      end.type = GridNodeType.normal;
    }
    end = grid[y][x];

    // 设置终点时，重置之前的路径
    _clearPath();
    emit(state.copyWith(end: end));
  }

  FutureOr<void> _onUpdateGrid(
    UpdateGrid event,
    Emitter<PathfindingState> emit,
  ) async {
    final grid = event.grid;
    emit(state.copyWith(grid: List.from(grid)));
  }

  FutureOr<void> _onPathfinding(
    Pathfinding event,
    Emitter<PathfindingState> emit,
  ) async {
    final grid = state.grid;
    final start = state.start!;
    final end = state.end!;
    _aStarPathfinding(
      mapWidth: kGridSize,
      mapHeight: kGridSize,
      startNode: AStarNode(start.x, start.y),
      endNode: AStarNode(end.x, end.y),
      canMoveDelegate: (x, y) {
        final node = grid[y][x];
        return node.type != GridNodeType.obstacle;
      },
      nodeCallback: (node, type) {
        if (grid[node.y][node.x].type == GridNodeType.start) {
          return;
        }
        if (grid[node.y][node.x].type == GridNodeType.end) {
          return;
        }
        grid[node.y][node.x].type = type;
        grid[node.y][node.x].gCost = node.gCost;
        grid[node.y][node.x].hCost = node.hCost;
        add(UpdateGrid(grid));
      },
      fallbackClosestNode: true,
    );
  }

  void _clearPath() {
    final grid = state.grid;
    if (grid.isEmpty) {
      return;
    }
    for (int y = 0; y < kGridSize; y++) {
      for (int x = 0; x < kGridSize; x++) {
        final node = grid[y][x];
        final type = node.type;
        switch (type) {
          case GridNodeType.pending:
          case GridNodeType.path:
            node.type = GridNodeType.normal;
            node.gCost = null;
            node.hCost = null;
            break;
          default:
            break;
        }
      }
    }
  }

  Future<List<AStarNode>?> _aStarPathfinding({
    required int mapWidth,
    required int mapHeight,
    required AStarNode startNode,
    required AStarNode endNode,
    required CanMoveDelegate canMoveDelegate,
    required PathfindingDelegate nodeCallback,
    bool fallbackClosestNode = false,
  }) async {
    // 记录下所有被考虑来寻找最短路径的格子
    List<AStarNode> openList = [];
    // 记录下不会再被考虑的格子
    List<AStarNode> closedList = [];
    // 距离目标点最近的可达点（假如目标点不可达）
    AStarNode? closestNode;

    openList.add(startNode);

    AStarNode curNode;
    while (openList.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));

      // 从 OPEN 表中取估价值f最小的节点n;
      curNode = openList[0];

      for (int i = 0, max = openList.length; i < max; i++) {
        if (openList[i].fCost <= curNode.fCost &&
            openList[i].hCost < curNode.hCost) {
          curNode = openList[i];
        }
      }
      openList.remove(curNode);
      closedList.add(curNode);

      nodeCallback.call(curNode, GridNodeType.pending);

      // 找到的目标节点
      if (curNode.x == endNode.x && curNode.y == endNode.y) {
        return _generatePath(startNode, curNode, nodeCallback);
      }

      // 记录最接近目标点的可达点
      if (fallbackClosestNode) {
        if (curNode != startNode) {
          if (closestNode == null) {
            closestNode = curNode;
          } else {
            int newDist = AStar.getDistanceNodes(curNode, endNode);
            int oldDist = AStar.getDistanceNodes(closestNode, endNode);
            if (newDist < oldDist) {
              closestNode = curNode;
            }
          }
        }
      }

      // 判断周围节点，选择一个最优的节点
      List<AStarNode> neighbourhoodNode =
          AStar.getNeighbourhood(mapWidth, mapHeight, curNode);
      for (int j = 0, max = neighbourhoodNode.length; j < max; j++) {
        AStarNode item = neighbourhoodNode[j];
        if (closedList.contains(item)) {
          // 已经在关闭列表中
          continue;
        }

        if (!canMoveDelegate.call(item.x, item.y)) {
          closedList.add(item);
          continue;
        }

        // 计算当前相领节点现开始节点距离
        int newCost = curNode.gCost + AStar.getDistanceNodes(curNode, item);
        // 如果距离更小，或者原来不在开始列表中
        if (newCost < item.gCost || !openList.contains(item)) {
          // 更新与开始节点的距离
          item.gCost = newCost;
          // 更新与终点的距离
          item.hCost = AStar.getDistanceNodes(item, endNode);
          // 更新父节点为当前选定的节点
          item.parent = curNode;
          // 如果节点是新加入的，将它加入打开列表中
          if (!openList.contains(item)) {
            openList.add(item);
          }
        }
      }
    }

    // 没有可达路径能到达目标点；可接受到达最近的可达点
    if (fallbackClosestNode && closestNode != null) {
      return _generatePath(
        startNode,
        closestNode,
        nodeCallback,
        includeEnd: true,
      );
    }
    return null;
  }

  Future<List<AStarNode>> _generatePath(
    AStarNode startNode,
    AStarNode? endNode,
    PathfindingDelegate nodeCallback, {
    bool includeEnd = false,
  }) async {
    List<AStarNode> path = [];
    if (endNode != null) {
      AStarNode? temp = endNode;
      if (includeEnd) {
        nodeCallback.call(temp, GridNodeType.path);
      }
      while (temp != null && (temp.x != startNode.x || temp.y != startNode.y)) {
        await Future.delayed(const Duration(milliseconds: 50));
        path.add(temp);
        temp = temp.parent;
        nodeCallback.call(temp!, GridNodeType.path);
      }
    }
    // 反转路径
    return path.reversed.toList();
  }
}
