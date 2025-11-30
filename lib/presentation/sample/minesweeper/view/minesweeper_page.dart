import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/minesweeper/bloc/minesweeper_bloc.dart';
import 'package:flutter_resume/presentation/sample/minesweeper/widget/mine_cell_widget.dart';
import 'package:flutter_resume/utils/utils.dart';

class MinesweeperPage extends StatelessWidget {
  const MinesweeperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minesweeper'),
      ),
      body: BlocProvider(
        create: (context) => MinesweeperBloc()..add(MinesweeperInitEvent()),
        child: const _MinesweeperView(),
      ),
    );
  }
}

class _MinesweeperView extends StatelessWidget {
  const _MinesweeperView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: _buildBoard(context),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.ss()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<MinesweeperBloc, MinesweeperState>(
            buildWhen: (p, c) => p.mineCount != c.mineCount || p.flagCount != c.flagCount,
            builder: (context, state) {
              return Text(
                'Mines: ${state.mineCount - state.flagCount}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<MinesweeperBloc>().add(MinesweeperInitEvent());
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard(BuildContext context) {
    return BlocConsumer<MinesweeperBloc, MinesweeperState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == MineSweeperGameStatus.won) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You Won!')),
          );
        } else if (state.status == MineSweeperGameStatus.lost) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Game Over!')),
          );
        }
      },
      builder: (context, state) {
        if (state.board.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: EdgeInsets.all(8.ss()),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MinesweeperBloc.cols,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: MinesweeperBloc.rows * MinesweeperBloc.cols,
          itemBuilder: (context, index) {
            final y = index ~/ MinesweeperBloc.cols;
            final x = index % MinesweeperBloc.cols;
            final cell = state.board[y][x];
            return MineCellWidget(
              cell: cell,
              onReveal: () {
                context.read<MinesweeperBloc>().add(MinesweeperRevealEvent(x, y));
              },
              onFlag: () {
                context.read<MinesweeperBloc>().add(MinesweeperFlagEvent(x, y));
              },
            );
          },
        );
      },
    );
  }
}
