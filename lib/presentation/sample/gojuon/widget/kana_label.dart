import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/gojuon/gojuon.dart';
import 'package:flutter_resume/utils/utils.dart';

class KanaLabel extends StatelessWidget {
  const KanaLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GojuonBloc, GojuonState>(
      buildWhen: (p, c) {
        return (p.kana != c.kana) ||
            (p.isAskRomaji != c.isAskRomaji) ||
            (p.kanaType != c.kanaType);
      },
      builder: (context, state) {
        final kana = state.kana;
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
            final random = GojuonBloc.of(context).getRandomValue();
            label = (random % 2 == 1) ? kana.hiragana : kana.katakana;
            break;
        }
        return Text(
          isAskRomaji ? kana.romaji : label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 100.ss(),
          ),
        );
      },
    );
  }
}
