import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:math';

part 'editor_event.dart';

part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc({
    required this.iconSize,
  }) : super(EditorState()) {
    on<AddSticker>(_onAddSticker);
    on<PanDown>(_onPanDown);
    on<PanUpdate>(_onPanUpdate);
    on<PanEnd>(_onPanEnd);
    on<PanCancel>(_onPanCancel);
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
    emit(state.copyWith(stickers: [...state.stickers, sticker]));
  }

  void _onPanDown(PanDown event, Emitter<EditorState> emit) {
    final details = event.details;
    final stickers = state.stickers;
    var selectedSticker = state.selectedSticker;
    if (selectedSticker == null) {
      // 未选中 -> 可能选中
      debugPrint('onPanDown: 未选中 -> 可能选中');
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
        debugPrint('onPanDown: 已选中 -> 取消选中 or 切换选中别的');
        for (final e in stickers) {
          e.isSelected = e == selectedSticker;
        }
        emit(state.copyWith(
          stickers: List.from(stickers),
          selectedSticker: selectedSticker,
          clearSelectedSticker: selectedSticker == null,
        ));
      } else {
        // 已选中 -> 可能点击了控制按钮
        debugPrint('onPanDown: 已选中 -> 可能点击了控制按钮');
        _findStickerInRange(
          details.localPosition.dx,
          details.localPosition.dy,
          onTapTopLeft: () {
            debugPrint('onPanDown: 点击左上角删除');
            add(DeleteSticker(selectedSticker!));
          },
          onTapTopRight: () {
            debugPrint('onPanDown: 点击右上角置顶');
            add(SetStickerOnTop(selectedSticker!));
          },
          onTapBottomLeft: () {
            // todo
            showToast('TODO: 点到左下角（待实现）');
          },
          onTapBottomRight: () {
            debugPrint('onPanDown: 点击右下角拉伸旋转');
            emit(state.copyWith(isScaleOrRotate: true));
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
    if (state.isScaleOrRotate) {
      // todo
      final dx = details.delta.dx;
      final dy = details.delta.dy;
      final delta = max(dx, dy);
      selectedSticker.width += delta;
      selectedSticker.height += delta;
      emit(state.copyWith(stickers: List.from(state.stickers)));
    } else {
      selectedSticker.transform.translate(details.delta.dx, details.delta.dy);
      emit(state.copyWith(stickers: List.from(state.stickers)));
    }
  }

  void _onPanEnd(PanEnd event, Emitter<EditorState> emit) {
    emit(state.copyWith(isScaleOrRotate: false));
  }

  void _onPanCancel(PanCancel event, Emitter<EditorState> emit) {
    emit(state.copyWith(isScaleOrRotate: false));
  }

  void _onSetStickerOnTop(SetStickerOnTop event, Emitter<EditorState> emit) {
    final stickers = state.stickers;
    final targetSticker = event.sticker;
    stickers.remove(targetSticker);
    stickers.insert(stickers.length, targetSticker);
    emit(state.copyWith(stickers: List.from(stickers)));
  }

  void _onDeleteSticker(DeleteSticker event, Emitter<EditorState> emit) {
    final stickers = state.stickers;
    stickers.remove(event.sticker);
    emit(state.copyWith(
      stickers: List.from(stickers),
      clearSelectedSticker: true,
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
