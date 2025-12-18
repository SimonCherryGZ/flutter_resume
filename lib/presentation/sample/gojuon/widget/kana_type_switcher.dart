import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/gojuon/gojuon.dart';
import 'package:flutter_resume/utils/utils.dart';

class KanaTypeSwitcher extends StatelessWidget {
  const KanaTypeSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GojuonBloc.of(context);
    return GestureDetector(
      onTap: () {
        bloc.add(SwitchAskKanaType());
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width / 4,
        height: 50.ss(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.ss())),
          border: Border.all(color: Colors.black, width: 2.ss()),
        ),
        child: Center(
          child: BlocBuilder<GojuonBloc, GojuonState>(
            buildWhen: (p, c) {
              return p.kanaType != c.kanaType;
            },
            builder: (context, state) {
              final kanaType = state.kanaType;
              final String label;
              switch (kanaType) {
                case KanaType.hiragana:
                  label = 'あ';
                  break;
                case KanaType.katakana:
                  label = 'ア';
                  break;
                case KanaType.both:
                  label = 'あ + ア';
                  break;
              }
              return Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
