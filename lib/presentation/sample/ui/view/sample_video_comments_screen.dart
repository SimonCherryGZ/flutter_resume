import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/video/widget/video_player_widget.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';

class SampleVideoCommentsScreen extends StatelessWidget {
  const SampleVideoCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      body: _SampleVideoCommentsScreenContent(),
    );
  }
}

class _SampleVideoCommentsScreenContent extends StatefulWidget {
  @override
  _SampleVideoCommentsScreenContentState createState() =>
      _SampleVideoCommentsScreenContentState();
}

class _SampleVideoCommentsScreenContentState
    extends State<_SampleVideoCommentsScreenContent> {
  static const _maxChildSize = 0.7;

  late final DraggableScrollableController _sheetController;
  double _videoHeightRatio = 1.0;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();
    _sheetController.addListener(() {
      setState(() {
        _videoHeightRatio = 1.0 - (_sheetController.size);
      });
    });
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration.zero,
              width: screenWidth,
              height: screenHeight * _videoHeightRatio,
              color: const Color(0xFF333333),
              child: _VideoPlayerWidget(),
            ),
            Positioned(
              bottom: 150.ss(),
              right: 10.ss(),
              child: _ActionButtonGroup(
                onTapComment: () {
                  _toggleCommentsShow();
                },
              ),
            ),
            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: 0.0,
              minChildSize: 0.0,
              maxChildSize: _maxChildSize,
              snap: true,
              builder: (
                BuildContext context,
                ScrollController scrollController,
              ) {
                return _CommentsListWidget(
                  scrollController: scrollController,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleCommentsShow() {
    if (_sheetController.size < _maxChildSize / 2) {
      _sheetController.animateTo(
        _maxChildSize,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _sheetController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

class _VideoPlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(
      onCreateVideoPlayerController: () {
        return VideoPlayerController.asset(
          'assets/videos/sample_video_vertical.mp4',
        );
      },
      looping: true,
    );
  }
}

class _CommentsListWidget extends StatelessWidget {
  const _CommentsListWidget({
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.ss())),
      ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text((index + 1).toString()),
            ),
            title: Text("User $index"),
            subtitle: Text("This is comment number $index."),
          );
        },
      ),
    );
  }
}

class _ActionButtonGroup extends StatelessWidget {
  const _ActionButtonGroup({
    this.onTapComment,
  });

  final VoidCallback? onTapComment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            showToast('已点赞');
          },
          color: Colors.white,
          icon: const Icon(Icons.heart_broken_outlined),
        ),
        IconButton(
          onPressed: onTapComment,
          color: Colors.white,
          icon: const Icon(Icons.comment),
        ),
        IconButton(
          onPressed: () {
            showToast('已收藏');
          },
          color: Colors.white,
          icon: const Icon(Icons.star),
        ),
        IconButton(
          onPressed: () {
            showToast('转发，假的');
          },
          color: Colors.white,
          icon: const Icon(Icons.share),
        ),
      ],
    );
  }
}
