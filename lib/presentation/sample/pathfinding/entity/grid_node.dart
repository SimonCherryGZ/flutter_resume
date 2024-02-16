enum GridNodeType {
  normal,
  obstacle,
  start,
  end,
  pending,
  path,
}

class GridNode {
  int x = -1;
  int y = -1;
  GridNodeType type = GridNodeType.normal;
  int? gCost;
  int? hCost;
}
