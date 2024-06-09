import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/audio/audio.dart';
import 'package:flutter_resume/utils/utils.dart';

class SampleAudioPlayerScreen extends StatelessWidget {
  const SampleAudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: BlocProvider(
        create: (context) => AudioPlayerBloc(),
        child: _AudioPlayerScreenContent(),
      ),
    );
  }
}

class _AudioPlayerScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audios = [
      const MapEntry('SFX-1', 'assets/audios/sample_sfx_1.mp3'),
      const MapEntry('SFX-2', 'assets/audios/sample_sfx_2.mp3'),
      const MapEntry('BGM-1', 'assets/audios/sample_bgm_1.mp3'),
      const MapEntry('BGM-2', 'assets/audios/sample_bgm_2.mp3'),
    ];
    return Column(
      children: [
        SizedBox(height: 40.ss()),
        const DiscWidget(),
        SizedBox(height: 40.ss()),
        Expanded(
          child: ListView.builder(
            itemCount: audios.length,
            itemBuilder: (context, index) {
              final item = audios[index];
              return AudioItemWidget(
                assetsName: item.key,
                assetsPath: item.value,
              );
            },
          ),
        ),
        SizedBox(height: 20.ss()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.ss()),
          child: const ProgressBarWidget(),
        ),
        SizedBox(height: 20.ss()),
        const ControlWidget(),
        SizedBox(height: 50.ss()),
      ],
    );
  }
}
