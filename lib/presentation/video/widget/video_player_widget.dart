import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:video_player/video_player.dart';

typedef OnCreateVideoPlayerController = VideoPlayerController Function();

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.onCreateVideoPlayerController,
    this.looping = false,
  });

  final OnCreateVideoPlayerController onCreateVideoPlayerController;
  final bool looping;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoPlayerController;
  bool _pausedByUser = false;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _videoPlayerController;
    return controller == null
        ? const SizedBox.expand()
        : GestureDetector(
            onTap: () {
              if (controller.value.isPlaying) {
                controller.pause();
                _pausedByUser = true;
              } else {
                controller.play();
                _pausedByUser = false;
              }
            },
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                ),
                Center(
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      final isPlaying = value.isPlaying;
                      if (isPlaying || !_pausedByUser) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        width: 60.ss(),
                        height: 60.ss(),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 50.ss(),
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 16.ss(),
                  right: 16.ss(),
                  bottom: MediaQuery.paddingOf(context).bottom + 48.ss(),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 1.ss(),
                    child: VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      padding: const EdgeInsets.all(0),
                      colors: const VideoProgressColors(
                        playedColor: Colors.white,
                        bufferedColor: Color.fromRGBO(255, 255, 255, 0.5),
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> _loadVideo() async {
    _videoPlayerController?.dispose();
    _videoPlayerController = widget.onCreateVideoPlayerController.call();
    _videoPlayerController?.setLooping(widget.looping);
    _videoPlayerController?.removeListener(_videoStatusChanged);
    _videoPlayerController?.addListener(_videoStatusChanged);
    await _videoPlayerController?.initialize();
    await _videoPlayerController?.play();
    setState(() {});
  }

  void _videoStatusChanged() {
    if (!mounted) {
      return;
    }
    final controller = _videoPlayerController;
    if (controller == null) {
      return;
    }
    final value = controller.value;
    final isFinished = value.isInitialized &&
        (value.isCompleted || value.position == value.duration);
    if (isFinished) {
      _videoPlayerController?.seekTo(Duration.zero);
    }
  }
}
