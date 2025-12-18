import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/gojuon/gojuon.dart';
import 'package:flutter_resume/utils/utils.dart';

class AnswerButtonRow extends StatelessWidget {
  const AnswerButtonRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GojuonBloc.of(context);
    return BlocBuilder<GojuonBloc, GojuonState>(
      buildWhen: (p, c) {
        return !listEquals(p.optionAnswers, c.optionAnswers);
      },
      builder: (context, state) {
        final answers = state.optionAnswers;
        final List<int> randoms = [];
        for (final _ in answers) {
          final random = bloc.getRandomValue();
          randoms.add(random);
        }
        return BlocBuilder<GojuonBloc, GojuonState>(
          buildWhen: (p, c) {
            return !listEquals(p.wrongAnswers, c.wrongAnswers);
          },
          builder: (context, state) {
            int i = 0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: answers.map((kana) {
                int random = randoms[i];
                i++;
                return _AnswerButton(kana, random);
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final Kana kana;
  final int random;

  const _AnswerButton(
    this.kana,
    this.random, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GojuonBloc.of(context);
    return GestureDetector(
      onTap: () {
        bloc.add(ClickAnswer(kana));
      },
      child: BlocBuilder<GojuonBloc, GojuonState>(
        buildWhen: (p, c) {
          return (p.kana != c.kana) ||
              (p.isAskRomaji != c.isAskRomaji) ||
              (p.kanaType != c.kanaType) ||
              (!bloc.isWrongAnswer(p.kana) && bloc.isWrongAnswer(c.kana));
        },
        builder: (context, state) {
          final isAskRomaji = state.isAskRomaji;
          final kanaType = state.kanaType;
          final String label;
          switch (kanaType) {
            case KanaType.hiragana:
              label = kana.hiragana;
              break;
            case KanaType.katakana:
              label = kana.katakana;
              break;
            case KanaType.both:
              label = (random % 2 == 1) ? kana.hiragana : kana.katakana;
              break;
          }
          final isWrongAnswer = bloc.isWrongAnswer(kana);
          return Container(
            width: 50.ss(),
            height: 50.ss(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.ss())),
              border: Border.all(
                color: Colors.black,
                width: 2.ss(),
              ),
              color: isWrongAnswer ? Colors.red : Colors.transparent,
            ),
            child: Center(
              child: Text(
                isAskRomaji ? label : kana.romaji,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
