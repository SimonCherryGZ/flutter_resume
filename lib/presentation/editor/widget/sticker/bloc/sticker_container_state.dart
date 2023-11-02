part of 'sticker_container_bloc.dart';

class StickerContainerState {
  final List<WsElement> elements;

  StickerContainerState({
    this.elements = const [],
  });

  StickerContainerState copyWith({
    List<WsElement>? elements,
    Rect? editRect,
    Offset? offset,
  }) {
    return StickerContainerState(
      elements: elements ?? this.elements,
    );
  }
}
