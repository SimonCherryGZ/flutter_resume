import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/pathfinding/pathfinding.dart';
import 'package:flutter_resume/utils/utils.dart';

class PathfindingScreen extends StatelessWidget {
  const PathfindingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pathfinding'),
      ),
      body: BlocProvider(
        create: (context) => PathfindingBloc()..add(InitGrid()),
        child: _PathfindingScreenContent(),
      ),
    );
  }
}

class _PathfindingScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('点按格子设置为起点\n长按格子设置为终点'),
        Flexible(
          child: Container(
            color: Colors.grey,
            margin: EdgeInsets.all(10.ss()),
            padding: EdgeInsets.all(1.ss()),
            child: _GridView(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _PathfindingButton(),
            _RandomizeButton(),
          ],
        ),
      ],
    );
  }
}

class _GridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PathfindingBloc>();
    return BlocBuilder<PathfindingBloc, PathfindingState>(
      builder: (context, state) {
        final grid = state.grid;
        if (grid.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            mainAxisSpacing: 1.ss(),
            crossAxisSpacing: 1.ss(),
          ),
          itemCount: grid.length * grid[0].length,
          itemBuilder: (context, index) {
            final y = (index / kGridSize).floor();
            final x = index % kGridSize;
            final node = grid[y][x];
            Color color;
            switch (node.type) {
              case GridNodeType.normal:
                color = Colors.white;
                break;
              case GridNodeType.obstacle:
                color = Colors.red;
                break;
              case GridNodeType.start:
                color = Colors.blue;
                break;
              case GridNodeType.end:
                color = Colors.green;
                break;
              case GridNodeType.pending:
                color = Colors.white60;
                break;
              case GridNodeType.path:
                color = Colors.yellow;
                break;
            }
            return GestureDetector(
              onTap: () {
                bloc.add(SetNodeAsStart(node));
              },
              onLongPress: () {
                bloc.add(SetNodeAsEnd(node));
              },
              child: Container(
                color: color,
                child: node.gCost != null
                    ? Center(
                        child: Text(
                          '${node.gCost}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}

class _RandomizeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PathfindingBloc>();
    return ElevatedButton(
      onPressed: () {
        bloc.add(InitGrid());
      },
      child: const Text('重建网格'),
    );
  }
}

class _PathfindingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PathfindingBloc>();
    return ElevatedButton(
      onPressed: () {
        final start = bloc.state.start;
        if (start == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('未指定起点')));
          return;
        }
        final end = bloc.state.end;
        if (end == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('未指定终点')));
          return;
        }
        bloc.add(Pathfinding(start, end));
      },
      child: const Text('寻路'),
    );
  }
}
