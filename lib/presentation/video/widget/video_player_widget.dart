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

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    final isVideoReady = _videoPlayerController != null &&
        (_videoPlayerController?.value.isInitialized ?? false);
    return Center(
      child: !isVideoReady
          ? const CircularProgressIndicator()
          : GestureDetector(
              onTap: () {
                if (_videoPlayerController!.value.isPlaying) {
                  _videoPlayerController?.pause();
                } else {
                  _videoPlayerController?.play();
                }
              },
              child: Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio:
                          _videoPlayerController?.value.aspectRatio ?? 1,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                  ),
                  Center(
                    child: ValueListenableBuilder(
                      valueListenable: _videoPlayerController!,
                      builder: (context, value, child) {
                        final isPlaying = value.isPlaying;
                        if (isPlaying) {
                          return const SizedBox.shrink();
                        }
                        return Icon(
                          Icons.play_arrow,
                          size: 100.ss(),
                          color: Colors.white.withOpacity(0.75),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
