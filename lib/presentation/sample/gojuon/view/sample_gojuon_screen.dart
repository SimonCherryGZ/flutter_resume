import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/gojuon/gojuon.dart';

class SampleGojuonScreen extends StatelessWidget {
  const SampleGojuonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('五十音'),
      ),
      body: Center(
        child: BlocProvider(
          create: (context) => GojuonBloc()..add(AskRandomKana()),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KanaRomajiSwitcher(),
                  KanaTypeSwitcher(),
                  KanaSelectionButton(),
                ],
              ),
              KanaLabel(),
              AnswerButtonRow(),
            ],
          ),
        ),
      ),
    );
  }
}
