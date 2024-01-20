part of 'editor_bloc.dart';

abstract class EditorEvent {}

class AddAssetSticker extends EditorEvent {
  final String imagePath;
  final double width;
  final double height;

  AddAssetSticker({
    required this.imagePath,
    required this.width,
    required this.height,
  });
}

class ExportImage extends EditorEvent {
  ExportImage({
    this.cropRect,
  });

  final Rect? cropRect;
}
