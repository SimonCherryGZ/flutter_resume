import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/card_match/card_match.dart';
import 'package:flutter_resume/utils/utils.dart';

class SampleCardMatchScreen extends StatelessWidget {
  const SampleCardMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(
        title: const Text('Card Match'),
      ),
      body: BlocProvider(
        create: (context) => CardMatchCubit()..init(),
        child: _CardMatchScreenContent(),
      ),
    );
  }
}

class _CardMatchScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CardMatchCubit>();
    return Column(
      children: [
        SizedBox(height: 20.ss()),
        BlocBuilder<CardMatchCubit, CardMatchState>(
          buildWhen: (p, c) => p.score != c.score,
          builder: (context, state) {
            return Text(
              'Score: ${state.score}',
              style: const TextStyle(
                color: Colors.white,
              ),
            );
          },
        ),
        BlocBuilder<CardMatchCubit, CardMatchState>(
          buildWhen: (p, c) => p.combo != c.combo,
          builder: (context, state) {
            return Text(
              'Combo: ${state.combo}',
              style: const TextStyle(
                color: Colors.white,
              ),
            );
          },
        ),
        Expanded(
          child: Center(
            child: BlocBuilder<CardMatchCubit, CardMatchState>(
              builder: (context, state) {
                return GridView.builder(
                  key: ValueKey(state.round),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.ss()),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 222 / 323,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.ss(),
                    crossAxisSpacing: 4.ss(),
                  ),
                  itemCount: state.cards.length,
                  itemBuilder: (context, index) {
                    final card = state.cards[index];
                    return CardWidget(
                      key: ValueKey(index),
                      assetName: card.assetName,
                      onMatch: () async {
                        return await cubit.selectCard(card);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            cubit.init();
          },
          child: const Text('Reset'),
        ),
        SizedBox(height: 20.ss()),
      ],
    );
  }
}
