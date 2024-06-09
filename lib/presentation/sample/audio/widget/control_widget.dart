import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/audio/audio.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class ControlWidget extends StatelessWidget {
  const ControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AudioPlayerBloc>();
    return SizedBox(
      height: 48.ss(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              // todo - 待实现
              showToast('TODO: 开发中');
            },
            icon: Transform.scale(
              scaleX: -1,
              child: const Icon(
                Icons.skip_previous,
              ),
            ),
          ),
          SizedBox(width: 20.ss()),
          BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
            buildWhen: (p, c) => p.playing != c.playing,
            builder: (context, state) {
              final playing = state.playing;
              return IconButton(
                onPressed: () {
                  if (playing) {
                    bloc.add(Pause());
                  } else {
                    bloc.add(Play());
                  }
                },
                icon: Icon(playing ? Icons.pause : Icons.play_arrow),
              );
            },
          ),
          SizedBox(width: 20.ss()),
          IconButton(
            onPressed: () {
              // todo - 待实现
              showToast('TODO: 开发中');
            },
            icon: const Icon(Icons.skip_next),
          ),
          SizedBox(width: 20.ss()),
          IconButton(
            onPressed: () {
              // todo - 待实现
              showToast('TODO: 开发中');
            },
            icon: const Icon(Icons.repeat),
          ),
        ],
      ),
    );
  }
}
