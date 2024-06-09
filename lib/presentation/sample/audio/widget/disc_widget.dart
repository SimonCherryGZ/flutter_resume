import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/sample/audio/audio.dart';
import 'package:flutter_resume/utils/utils.dart';

class DiscWidget extends StatefulWidget {
  const DiscWidget({
    super.key,
  });

  @override
  State<DiscWidget> createState() => _DiscWidgetState();
}

class _DiscWidgetState extends State<DiscWidget> {
  final RepeatedRotateWrapperController _controller =
      RepeatedRotateWrapperController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioPlayerBloc, AudioPlayerState>(
      listenWhen: (p, c) => p.playing != c.playing,
      listener: (context, state) {
        final playing = state.playing;
        if (playing) {
          _controller.resume();
        } else {
          _controller.pause();
        }
      },
      child: RepeatedRotateWrapper(
        controller: _controller,
        duration: const Duration(seconds: 5),
        autoPlay: false,
        child: Container(
          width: 200.ss(),
          height: 200.ss(),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: Center(
            child: Container(
              width: 100.ss(),
              height: 100.ss(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Icon(
                  Icons.music_note,
                  size: 50.ss(),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
