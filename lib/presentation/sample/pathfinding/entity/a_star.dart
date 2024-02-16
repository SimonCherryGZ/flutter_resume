import 'dart:math';

typedef CanMoveDelegate = bool Function(int x, int y);

// 如果图形中只允许朝上下左右四个方向移动，则可以使用曼哈顿距离（Manhattan distance）
// 如果图形中允许朝八个方向移动，则可以使用对角距离
// 如果图形中允许朝任何方向移动，则可以使用欧几里得距离（Euclidean distance）
class AStar {
  static const double _straightCost = 1;
  static const double _diagonalCost = 1.4;

  static List<AStarNode>? aStarPathfinding(
    int mapWidth,
    int mapHeight,
    AStarNode startNode,
    AStarNode endNode,
    CanMoveDelegate delegate, {
    bool fallbackClosestNode = false,
  }) {
    // 记录下所有被考虑来寻找最短路径的格子
    List<AStarNode> openList = [];
    // 记录下不会再被考虑的格子
    List<AStarNode> closedList = [];
    // 距离目标点最近的可达点（假如目标点不可达）
    AStarNode? closestNode;

    openList.add(startNode);

    AStarNode curNode;
    while (openList.isNotEmpty) {
      // 从 OPEN 表中取估价值f最小的节点n;
      curNode = openList[0];

      // 这一行的作用是什么？目前发现这个会导致判断有误
      // if (curNode == endNode) break;

      for (int i = 0, max = openList.length; i < max; i++) {
        if (openList[i].fCost <= curNode.fCost &&
            openList[i].hCost < curNode.hCost) {
          curNode = openList[i];
        }
      }
      openList.remove(curNode);
      closedList.add(curNode);

      // 找到的目标节点
      if (curNode.x == endNode.x && curNode.y == endNode.y) {
        return generatePath(startNode, curNode);
      }

      // 记录最接近目标点的可达点
      if (fallbackClosestNode) {
        if (curNode != startNode) {
          if (closestNode == null) {
            closestNode = curNode;
          } else {
            int newDist = getDistanceNodes(curNode, endNode);
            int oldDist = getDistanceNodes(closestNode, endNode);
            if (newDist < oldDist) {
              closestNode = curNode;
            }
          }
        }
      }

      // 判断周围节点，选择一个最优的节点
      List<AStarNode> neighbourhoodNode =
          getNeighbourhood(mapWidth, mapHeight, curNode);
      for (int j = 0, max = neighbourhoodNode.length; j < max; j++) {
        AStarNode item = neighbourhoodNode[j];
        if (closedList.contains(item)) {
          // 已经在关闭列表中
          continue;
        }

        if (!delegate.call(item.x, item.y)) {
          closedList.add(item);
          continue;
        }

        // 计算当前相领节点现开始节点距离
        int newCost = curNode.gCost + getDistanceNodes(curNode, item);
        // 如果距离更小，或者原来不在开始列表中
        if (newCost < item.gCost || !openList.contains(item)) {
          // 更新与开始节点的距离
          item.gCost = newCost;
          // 更新与终点的距离
          item.hCost = getDistanceNodes(item, endNode);
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
      return generatePath(
        startNode,
        closestNode,
        includeEnd: true,
      );
    }
    return null;
  }

  static List<AStarNode> getNeighbourhood(
      int width, int height, AStarNode node) {
    List<AStarNode> nodeList = [];

    int x, y;
    x = node.x - 1;
    y = node.y;
    if (x >= 0 && x < width && y >= 0 && y < height) {
      nodeList.add(AStarNode(x, y));
    }

    x = node.x + 1;
    y = node.y;
    if (x >= 0 && x < width && y >= 0 && y < height) {
      nodeList.add(AStarNode(x, y));
    }

    x = node.x;
    y = node.y - 1;
    if (x >= 0 && x < width && y >= 0 && y < height) {
      nodeList.add(AStarNode(x, y));
    }

    x = node.x;
    y = node.y + 1;
    if (x >= 0 && x < width && y >= 0 && y < height) {
      nodeList.add(AStarNode(x, y));
    }

    return nodeList;
  }

  static List<AStarNode> generatePath(
    AStarNode startNode,
    AStarNode? endNode, {
    bool includeEnd = false,
  }) {
    List<AStarNode> path = [];
    if (endNode != null) {
      AStarNode? temp = endNode;
      if (includeEnd) {
        path.add(temp);
        temp = temp.parent;
      }
      while (temp != null && (temp.x != startNode.x || temp.y != startNode.y)) {
        path.add(temp);
        temp = temp.parent;
      }
    }
    // 反转路径
    return path.reversed.toList();
  }

  // 获取两个节点之间的距离
  static int getDistanceNodes(AStarNode a, AStarNode b) {
    return (manhattan(a, b)).toInt();
  }

  // 启发法
  static double heuristic(AStarNode a, AStarNode b) {
    //离目标的距离
    return ((a.x - b.x).abs() + (a.y - b.y).abs()).toDouble();
  }

  // 曼哈顿估价法
  static double manhattan(AStarNode a, AStarNode b) {
    return (a.x - b.x).abs() * _straightCost +
        (a.y - b.y).abs() * _straightCost;
  }

  // 几何估价法
  static double euclidian(AStarNode a, AStarNode b) {
    int dx = a.x - b.x;
    int dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy) * _straightCost;
  }

  // 对角线估价法
  static double diagonal(AStarNode a, AStarNode b) {
    double dx = (a.x - b.x).abs().toDouble();
    double dy = (a.y - b.y).abs().toDouble();
    double diag = min(dx, dy);
    double straight = dx + dy;
    return _diagonalCost * diag + _straightCost * (straight - 2 * diag);
  }
}

class AStarNode {
  // 格子坐标
  int x, y;

  // 与起点的长度
  int gCost = 0;

  // 与目标点的长度
  int hCost = 0;

  // 总的路径长度
  int get fCost {
    return gCost + hCost;
  }

  // 父节点
  AStarNode? parent;

  AStarNode(
    this.x,
    this.y,
  );

  @override
  bool operator ==(Object other) {
    AStarNode otherItem = other as AStarNode;
    return x == otherItem.x && y == otherItem.y;
  }

  @override
  int get hashCode {
    int hash = 13;
    hash = (hash * 7) + x.hashCode;
    hash = (hash * 7) + y.hashCode;
    return hash;
  }
}
