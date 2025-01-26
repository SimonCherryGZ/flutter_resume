import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/video/widget/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class SampleVideoPageViewScreen extends StatelessWidget {
  const SampleVideoPageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _VideoPageViewScreenContent(),
    );
  }
}

class _VideoPageViewScreenContent extends StatefulWidget {
  @override
  State<_VideoPageViewScreenContent> createState() =>
      _VideoPageViewScreenContentState();
}

class _VideoPageViewScreenContentState
    extends State<_VideoPageViewScreenContent> {
  static const _videoUrls = [
    'https://media.w3.org/2010/05/sintel/trailer.mp4',
    'https://www.w3school.com.cn/example/html5/mov_bbb.mp4',
    'https://www.w3schools.com/html/movie.mp4',
    'https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4',
    'https://stream7.iqilu.com/10339/upload_transcode/202002/09/20200209105011F0zPoYzHry.mp4',
    'https://stream7.iqilu.com/10339/upload_transcode/202002/09/20200209104902N3v5Vpxuvb.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _videoUrls.length,
        itemBuilder: (context, index) {
          final url = _videoUrls[index];
          return VideoPlayerWidget(
            onCreateVideoPlayerController: () {
              return VideoPlayerController.networkUrl(Uri.parse(url));
            },
            looping: true,
          );
        },
      ),
    );
  }
}
