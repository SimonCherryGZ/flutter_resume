import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/video/video.dart';
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
      body: VideoPlayerWidget(
        onCreateVideoPlayerController: () {
          return VideoPlayerController.asset(videoAssetPath);
        },
      ),
    );
  }
}
