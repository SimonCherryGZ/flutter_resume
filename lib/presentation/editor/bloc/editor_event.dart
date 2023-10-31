part of 'editor_bloc.dart';

abstract class EditorEvent {}

class AddSticker extends EditorEvent {
  final String imagePath;

  AddSticker(this.imagePath);
}

class PanDown extends EditorEvent {
  final DragDownDetails details;

  PanDown(this.details);
}

class PanUpdate extends EditorEvent {
  final DragUpdateDetails details;

  PanUpdate(this.details);
}

class PanEnd extends EditorEvent {}

class PanCancel extends EditorEvent {}

class SetStickerOnTop extends EditorEvent {
  final StickerConfig sticker;

  SetStickerOnTop(this.sticker);
}

class DeleteSticker extends EditorEvent {
  final StickerConfig sticker;

  DeleteSticker(this.sticker);
}
