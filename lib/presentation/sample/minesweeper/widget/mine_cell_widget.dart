import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/minesweeper/bloc/minesweeper_bloc.dart';

class MineCellWidget extends StatelessWidget {
  final Cell cell;
  final VoidCallback onReveal;
  final VoidCallback onFlag;

  const MineCellWidget({
    super.key,
    required this.cell,
    required this.onReveal,
    required this.onFlag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onReveal,
      onLongPress: onFlag,
      onSecondaryTap: onFlag,
      child: Container(
        decoration: BoxDecoration(
          color: cell.isRevealed
              ? (cell.isMine ? Colors.red : Colors.grey[300])
              : Colors.blueGrey,
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (cell.isFlagged) {
      return const Icon(Icons.flag, color: Colors.red, size: 20);
    }
    if (cell.isRevealed) {
      if (cell.isMine) {
        return const Icon(Icons.error, color: Colors.black, size: 20);
      }
      if (cell.adjacentMines > 0) {
        return Text(
          '${cell.adjacentMines}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getNumberColor(cell.adjacentMines),
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }

  Color _getNumberColor(int number) {
    switch (number) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      case 4:
        return Colors.purple;
      case 5:
        return Colors.amber;
      case 6:
        return Colors.teal;
      case 7:
        return Colors.black;
      case 8:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}
