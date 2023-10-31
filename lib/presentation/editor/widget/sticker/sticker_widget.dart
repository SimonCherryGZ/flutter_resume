import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';

class StickerWidget extends StatelessWidget {
  const StickerWidget({
    super.key,
    required this.stickerConfig,
    this.iconSize = 20,
  });

  final StickerConfig stickerConfig;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final imagePath = stickerConfig.imagePath;
    final width = stickerConfig.width;
    final height = stickerConfig.height;
    final transform = stickerConfig.transform;
    final isSelected = stickerConfig.isSelected;
    return Positioned(
      left: -width / 2 - iconSize / 2,
      top: -height / 2 - iconSize / 2,
      child: Transform(
        transform: transform,
        child: SizedBox(
          width: width + iconSize,
          height: height + iconSize,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  imagePath,
                  width: width,
                  height: height,
                  fit: BoxFit.contain,
                ),
              ),
              Offstage(
                offstage: !isSelected,
                child: _FrameWidget(iconSize: iconSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FrameWidget extends StatelessWidget {
  const _FrameWidget({required this.iconSize});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(iconSize / 2),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: _FrameIcon(
            iconSize: iconSize,
            iconData: Icons.close,
          ),
        ),
        Positioned(
          right: 0,
          child: _FrameIcon(
            iconSize: iconSize,
            iconData: Icons.upload_rounded,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _FrameIcon(
            iconSize: iconSize,
            iconData: Icons.rotate_left,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: _FrameIcon(
            iconSize: iconSize,
            iconData: Icons.flip,
          ),
        ),
      ],
    );
  }
}

class _FrameIcon extends StatelessWidget {
  const _FrameIcon({
    required this.iconSize,
    required this.iconData,
  });

  final double iconSize;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: iconSize,
        height: iconSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          iconData,
          size: iconSize * 2 / 3,
          color: Colors.grey,
        ),
      ),
    );
  }
}
