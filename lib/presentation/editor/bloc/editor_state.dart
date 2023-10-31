part of 'editor_bloc.dart';

class EditorState {
  final List<StickerConfig> stickers;
  final StickerConfig? selectedSticker;
  final bool isScaleOrRotate;

  EditorState({
    this.stickers = const [],
    this.selectedSticker,
    this.isScaleOrRotate = false,
  });

  EditorState copyWith({
    List<StickerConfig>? stickers,
    StickerConfig? selectedSticker,
    bool clearSelectedSticker = false,
    bool? isScaleOrRotate,
  }) {
    return EditorState(
      stickers: stickers ?? this.stickers,
      selectedSticker: clearSelectedSticker
          ? null
          : (selectedSticker ?? this.selectedSticker),
      isScaleOrRotate: isScaleOrRotate ?? this.isScaleOrRotate,
    );
  }
}
