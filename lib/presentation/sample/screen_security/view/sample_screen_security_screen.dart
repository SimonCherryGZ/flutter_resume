import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_security/screen_security.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class SampleScreenSecurityScreen extends StatefulWidget {
  const SampleScreenSecurityScreen({super.key});

  @override
  State<SampleScreenSecurityScreen> createState() =>
      _SampleScreenSecurityScreenState();
}

class _SampleScreenSecurityScreenState extends State<SampleScreenSecurityScreen>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouter.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppRouter.routeObserver.unsubscribe(this);
    ScreenSecurity.disable();
    super.dispose();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    ScreenSecurity.enable();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    ScreenSecurity.disable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Security'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('点击查看大图 🔍\n（演示限制截屏）'),
              Padding(
                padding: EdgeInsets.all(10.ss()),
                child: GestureDetector(
                  onTap: () {
                    context.goNamed(
                      AppRouter.sampleScreenSecurityPhotoView,
                      extra:
                          const AssetImage('assets/images/sample_photo_1.jpg'),
                    );
                  },
                  child: Image.asset(
                    'assets/images/sample_photo_1.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 50.ss()),
              const Text('点击播放视频 ▶️\n（演示限制录屏）'),
              Padding(
                padding: EdgeInsets.all(10.ss()),
                child: FutureBuilder(
                  future: _loadVideoThumb(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final videoThumbPath = snapshot.data;
                    if (videoThumbPath == null) {
                      return const CircularProgressIndicator();
                    }
                    const videoPath = 'assets/videos/sample_video.mp4';
                    return GestureDetector(
                      onTap: () {
                        context.goNamed(
                          AppRouter.sampleScreenSecurityVideoPlayer,
                          extra: videoPath,
                        );
                      },
                      child: Image.file(
                        File(videoThumbPath),
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _loadVideoThumb() async {
    final tempDir = await getTemporaryDirectory();
    final tempVideo = File('${tempDir.path}/videos/sample_video.mp4');
    final exists = await tempVideo.exists();
    if (!exists) {
      final byteData = await rootBundle.load('assets/videos/sample_video.mp4');
      final bytes = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      await tempVideo.create(recursive: true);
      await tempVideo.writeAsBytes(bytes);
    }
    return VideoThumbnail.thumbnailFile(
      video: tempVideo.path,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );
  }
}
