part of 'editor_bloc.dart';

class EditorState {
  final List<StickerConfig> stickers;
  final StickerConfig? selectedSticker;

  EditorState({
    this.stickers = const [],
    this.selectedSticker,
  });

  EditorState copyWith({
    List<StickerConfig>? stickers,
    StickerConfig? selectedSticker,
  }) {
    return EditorState(
      stickers: stickers ?? this.stickers,
      selectedSticker: selectedSticker,
    );
  }
}
