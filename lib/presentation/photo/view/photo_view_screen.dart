import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({
    super.key,
    required this.imageProvider,
  });

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const SizedBox.shrink(),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: imageProvider,
          initialScale: PhotoViewComputedScale.contained * 1,
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}
