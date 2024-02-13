import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/gojuon/gojuon.dart';
import 'package:flutter_resume/utils/utils.dart';

class KanaRomajiSwitcher extends StatelessWidget {
  const KanaRomajiSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GojuonBloc.of(context);
    return GestureDetector(
      onTap: () {
        bloc.add(SwitchAskMode());
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width / 4,
        height: 50.ss(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.ss())),
          border: Border.all(
            color: Colors.black,
            width: 2.ss(),
          ),
        ),
        child: Center(
          child: BlocBuilder<GojuonBloc, GojuonState>(
            buildWhen: (p, c) {
              return p.isAskRomaji != c.isAskRomaji;
            },
            builder: (context, state) {
              final isAskRomaji = state.isAskRomaji;
              return Text(
                isAskRomaji ? 'a → あ' : 'あ → a',
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
