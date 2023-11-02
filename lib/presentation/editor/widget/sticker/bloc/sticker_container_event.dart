part of 'sticker_container_bloc.dart';

abstract class StickerContainerEvent {}

class AddAssetStickerToContainer extends StickerContainerEvent {
  final String imagePath;
  final double width;
  final double height;

  AddAssetStickerToContainer({
    required this.imagePath,
    required this.width,
    required this.height,
  });
}

class PointerDown extends StickerContainerEvent {
  final PointerDownEvent event;

  PointerDown(this.event);
}

class PointerUp extends StickerContainerEvent {
  final PointerUpEvent event;

  PointerUp(this.event);
}

class PanUpdate extends StickerContainerEvent {
  final DragUpdateDetails details;

  PanUpdate(this.details);
}

class DoubleFingerScaleAndRotateStart extends StickerContainerEvent {
  final RotateScaleStartDetails details;

  DoubleFingerScaleAndRotateStart(this.details);
}

class DoubleFingerScaleAndRotateProcess extends StickerContainerEvent {
  final RotateScaleUpdateDetails details;

  DoubleFingerScaleAndRotateProcess(this.details);
}

class DoubleFingerScaleAndRotateEnd extends StickerContainerEvent {
  final RotateScaleEndDetails details;

  DoubleFingerScaleAndRotateEnd(this.details);
}
