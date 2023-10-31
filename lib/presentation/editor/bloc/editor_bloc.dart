import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';
import 'package:oktoast/oktoast.dart';

part 'editor_event.dart';

part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc({
    required this.iconSize,
  }) : super(EditorState()) {
    on<AddSticker>(_onAddSticker);
    on<PanDown>(_onPanDown);
    on<PanUpdate>(_onPanUpdate);
    on<SetStickerOnTop>(_onSetStickerOnTop);
    on<DeleteSticker>(_onDeleteSticker);
  }

  final double iconSize;
  int _stickerIncrementCounter = 1;

  void _onAddSticker(AddSticker event, Emitter<EditorState> emit) {
    final sticker = StickerConfig(
      id: '${_stickerIncrementCounter++}',
      imagePath: event.imagePath,
      // todo - 数值待计算
      width: 100,
      height: 100,
      transform: Matrix4.identity()..translate(200.0, 200.0),
    );
    emit(state.copyWith(
      stickers: [...state.stickers, sticker],
      selectedSticker: state.selectedSticker,
    ));
  }

  void _onPanDown(PanDown event, Emitter<EditorState> emit) {
    final details = event.details;
    final stickers = state.stickers;
    var selectedSticker = state.selectedSticker;
    if (selectedSticker == null) {
      // 未选中 -> 可能选中
      selectedSticker = _findStickerInRange(
        details.localPosition.dx,
        details.localPosition.dy,
      );
      for (final e in stickers) {
        e.isSelected = e == selectedSticker;
      }
      emit(state.copyWith(
        stickers: List.from(stickers),
        selectedSticker: selectedSticker,
      ));
    } else {
      final lastSelectedSticker = selectedSticker;
      selectedSticker = _findStickerInRange(
        details.localPosition.dx,
        details.localPosition.dy,
      );
      if (selectedSticker == null ||
          selectedSticker.id != lastSelectedSticker.id) {
        // 已选中 -> 点击空白区域，取消选中
        // or
        // 已选中 -> 切换选中别的
        for (final e in stickers) {
          e.isSelected = e == selectedSticker;
        }
        emit(state.copyWith(
          stickers: List.from(stickers),
          selectedSticker: selectedSticker,
        ));
      } else {
        // 已选中 -> 可能点击了控制按钮
        _findStickerInRange(
          details.localPosition.dx,
          details.localPosition.dy,
          onTapTopLeft: () {
            add(DeleteSticker(selectedSticker!));
          },
          onTapTopRight: () {
            add(SetStickerOnTop(selectedSticker!));
          },
          onTapBottomLeft: () {
            // todo
            showToast('TODO: 点到左下角（待实现）');
          },
          onTapBottomRight: () {
            // todo
            showToast('TODO: 点到右下角（待实现）');
          },
        );
      }
    }
  }

  void _onPanUpdate(PanUpdate event, Emitter<EditorState> emit) {
    final selectedSticker = state.selectedSticker;
    if (selectedSticker == null) {
      return;
    }
    final details = event.details;
    selectedSticker.transform.translate(details.delta.dx, details.delta.dy);
    emit(state.copyWith(
      stickers: List.from(state.stickers),
      selectedSticker: selectedSticker,
    ));
  }

  void _onSetStickerOnTop(SetStickerOnTop event, Emitter<EditorState> emit) {
    final stickers = state.stickers;
    final targetSticker = event.sticker;
    stickers.remove(targetSticker);
    stickers.insert(stickers.length, targetSticker);
    emit(state.copyWith(
      stickers: List.from(stickers),
      selectedSticker: state.selectedSticker,
    ));
  }

  void _onDeleteSticker(DeleteSticker event, Emitter<EditorState> emit) {
    final stickers = state.stickers;
    stickers.remove(event.sticker);
    emit(state.copyWith(
      stickers: List.from(stickers),
      selectedSticker: state.selectedSticker,
    ));
  }

  StickerConfig? _findStickerInRange(
    double x,
    double y, {
    VoidCallback? onTapTopLeft,
    VoidCallback? onTapTopRight,
    VoidCallback? onTapBottomLeft,
    VoidCallback? onTapBottomRight,
  }) {
    final stickers = state.stickers;
    final length = stickers.length;
    for (int i = length - 1; i >= 0; i--) {
      final e = stickers[i];
      if (e.isInRange(
        x,
        y,
        iconSize,
        onTapTopLeft: onTapTopLeft,
        onTapTopRight: onTapTopRight,
        onTapBottomLeft: onTapBottomLeft,
        onTapBottomRight: onTapBottomRight,
      )) {
        return e;
      }
    }
    return null;
  }
}
