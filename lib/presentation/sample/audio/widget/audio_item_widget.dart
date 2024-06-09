import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/audio/audio.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:provider/provider.dart';

class AudioItemWidget extends StatelessWidget {
  const AudioItemWidget({
    super.key,
    required this.assetsName,
    required this.assetsPath,
  });

  final String assetsName;
  final String assetsPath;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AudioPlayerBloc>();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        bloc.add(SwitchAudio(assetsPath));
      },
      child: SizedBox(
        height: 48.ss(),
        child: Center(
          child: Text(assetsName),
        ),
      ),
    );
  }
}
