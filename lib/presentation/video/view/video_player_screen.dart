import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({
    super.key,
    required this.videoAssetPath,
  });

  final String videoAssetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const SizedBox.shrink(),
        backgroundColor: Colors.transparent,
      ),
      body: _VideoPlayerContent(videoAssetPath: videoAssetPath),
    );
  }
}

class _VideoPlayerContent extends StatefulWidget {
  const _VideoPlayerContent({
    required this.videoAssetPath,
  });

  final String videoAssetPath;

  @override
  State<_VideoPlayerContent> createState() => _VideoPlayerContentState();
}

class _VideoPlayerContentState extends State<_VideoPlayerContent> {
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
    _videoPlayerController = VideoPlayerController.asset(widget.videoAssetPath);
    _videoPlayerController?.setLooping(false);
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
