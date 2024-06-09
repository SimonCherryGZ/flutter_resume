import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/audio/audio.dart';
import 'package:flutter_resume/utils/utils.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AudioPlayerBloc>();
    return SizedBox(
      height: 48.ss(),
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        buildWhen: (p, c) => p.progress != c.progress,
        builder: (context, state) {
          final progress = state.progress ?? 0;
          return Slider(
            value: max(0, min(progress, 1)),
            onChanged: (value) {
              bloc.add(SeekToProgress(value));
            },
          );
        },
      ),
    );
  }
}
