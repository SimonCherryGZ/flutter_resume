// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';

part 'sticker_container_event.dart';

part 'sticker_container_state.dart';

enum BaseActionMode {
  MOVE,
  SELECT,
  SELECTED_CLICK_OR_MOVE,
  SINGLE_TAP_BLANK_SCREEN,
  DOUBLE_FINGER_SCALE_AND_ROTATE,
}

enum DecorationActionMode {
  NONE,
  SINGER_FINGER_SCALE_AND_ROTATE,
  CLICK_BUTTON_DELETE,
}

class StickerContainerBloc
    extends Bloc<StickerContainerEvent, StickerContainerState> {
  StickerContainerBloc({
    required Rect editRect,
    required Offset offset,
  })  : _editRect = editRect,
        _offset = offset,
        super(StickerContainerState()) {
    on<AddAssetStickerToContainer>(_onAddAssetSticker);
    on<PointerDown>(_onPointerDown);
    on<PointerUp>(_onPointerUp);
    on<PanUpdate>(_onPanUpdate);
    on<DoubleFingerScaleAndRotateStart>(_onDoubleFingerScaleAndRotateStart);
    on<DoubleFingerScaleAndRotateProcess>(_onDoubleFingerScaleAndRotateProcess);
    on<DoubleFingerScaleAndRotateEnd>(_onDoubleFingerScaleAndRotateEnd);
  }

  final Rect _editRect;
  final Offset _offset;
  var _mode = BaseActionMode.SELECTED_CLICK_OR_MOVE;
  var _actionMode = DecorationActionMode.NONE;
  WsElement? _selectedElement;

  void _onAddAssetSticker(
      AddAssetStickerToContainer event, Emitter<StickerContainerState> emit) {
    final assetSticker = AssetStickerElement(
      event.imagePath,
      originWidth: event.width,
      originHeight: event.height,
      editRect: _editRect,
      offset: _offset,
    );
    emit(state.copyWith(elements: [...state.elements, assetSticker]));
  }

  void _onPointerDown(PointerDown event, Emitter<StickerContainerState> emit) {
    final e = event.event;
    // final x = _getRelativeX(e.position.dx);
    // final y = _getRelativeY(e.position.dy);
    final x = _getRelativeX(e.localPosition.dx);
    final y = _getRelativeY(e.localPosition.dy);
    _mode = BaseActionMode.SELECTED_CLICK_OR_MOVE;
    final clickedElement = _findElementByPosition(x, y);
    final selectedElement = _selectedElement;
    if (selectedElement != null) {
      if (isSameElement(clickedElement, selectedElement)) {
        bool result = _downSelectTapOtherAction(e);
        if (result) {
          return;
        }
        if (selectedElement.isInWholeDecoration(x, y)) {
          _mode = BaseActionMode.SELECTED_CLICK_OR_MOVE;
          return;
        }
      } else {
        if (clickedElement == null) {
          _mode = BaseActionMode.SINGLE_TAP_BLANK_SCREEN;
          _unSelectElement();
          _update(emit);
        } else {
          _mode = BaseActionMode.SELECT;
          _unSelectElement();
          _selectElement(clickedElement);
          _update(emit);
        }
      }
    } else {
      if (clickedElement != null) {
        _mode = BaseActionMode.SELECT;
        _selectElement(clickedElement);
        _update(emit);
      } else {
        _mode = BaseActionMode.SINGLE_TAP_BLANK_SCREEN;
        _unSelectElement();
        _update(emit);
      }
    }
  }

  void _onPointerUp(PointerUp event, Emitter<StickerContainerState> emit) {
    if (!_upSelectTapOtherAction(event.event, emit)) {
      switch (_mode) {
        case BaseActionMode.SELECTED_CLICK_OR_MOVE:
          _update(emit);
          return;
        case BaseActionMode.SINGLE_TAP_BLANK_SCREEN:
          return;
        case BaseActionMode.MOVE:
          _onSingleFingerMoveEnd(emit);
          return;
        default:
      }
    }
  }

  void _onPanUpdate(PanUpdate event, Emitter<StickerContainerState> emit) {
    List<DragUpdateDetails> dragUpdateDetailList = [event.details];
    if (_scrollSelectTapOtherAction(dragUpdateDetailList, emit)) {
      return;
    } else {
      if (_mode == BaseActionMode.SELECTED_CLICK_OR_MOVE ||
          _mode == BaseActionMode.SELECT ||
          _mode == BaseActionMode.MOVE) {
        if (_mode == BaseActionMode.SELECTED_CLICK_OR_MOVE ||
            _mode == BaseActionMode.SELECT) {
          _onSingleFingerMoveStart(dragUpdateDetailList[0], emit);
        } else {
          _onSingleFingerMoveProcess(dragUpdateDetailList[0], emit);
        }
        _update(emit);
        _mode = BaseActionMode.MOVE;
      }
    }
  }

  _onSingleFingerMoveStart(
    DragUpdateDetails d,
    Emitter<StickerContainerState> emit,
  ) {
    _selectedElement?.onSingleFingerMoveStart();
    _update(emit);
  }

  _onSingleFingerMoveProcess(
    DragUpdateDetails d,
    Emitter<StickerContainerState> emit,
  ) {
    _selectedElement?.onSingleFingerMoveProcess(d);
    _update(emit);
  }

  _onSingleFingerMoveEnd(Emitter<StickerContainerState> emit) {
    _selectedElement?.onSingleFingerMoveEnd();
    _update(emit);
  }

  void _onDoubleFingerScaleAndRotateStart(
    DoubleFingerScaleAndRotateStart event,
    Emitter<StickerContainerState> emit,
  ) {
    _selectedElement?.onDoubleFingerScaleAndRotateStart(event.details);
    _update(emit);
  }

  void _onDoubleFingerScaleAndRotateProcess(
    DoubleFingerScaleAndRotateProcess event,
    Emitter<StickerContainerState> emit,
  ) {
    _selectedElement?.onDoubleFingerScaleAndRotateProcess(event.details);
    _update(emit);
  }

  void _onDoubleFingerScaleAndRotateEnd(
    DoubleFingerScaleAndRotateEnd event,
    Emitter<StickerContainerState> emit,
  ) {
    _selectedElement?.onDoubleFingerScaleAndRotateEnd(event.details);
    _update(emit);
  }

  void _unSelectElement() {
    _selectedElement?.unSelect();
    _selectedElement = null;
  }

  void _selectElement(WsElement element) {
    element.select();
    _selectedElement = element;
  }

  void _update(Emitter<StickerContainerState> emit) {
    emit(state.copyWith());
  }

  double _getRelativeX(double screenX) {
    return screenX - _offset.dx;
  }

  double _getRelativeY(double screenY) {
    return screenY - _offset.dy;
  }

  WsElement? _findElementByPosition(double x, double y) {
    WsElement? realFoundedElement;
    final elements = state.elements;
    for (int i = elements.length - 1; i >= 0; i--) {
      WsElement nowElement = elements[i];
      if (nowElement.isInWholeDecoration(x, y)) {
        realFoundedElement = nowElement;
        break;
      }
    }
    return realFoundedElement;
  }

  bool _downSelectTapOtherAction(PointerDownEvent event) {
    _actionMode = DecorationActionMode.NONE;
    // final x = _getRelativeX(event.position.dx);
    // final y = _getRelativeY(event.position.dy);
    final x = _getRelativeX(event.localPosition.dx);
    final y = _getRelativeY(event.localPosition.dy);
    DecorationElement selectedDecorationElement =
        _selectedElement as DecorationElement;
    if (selectedDecorationElement.isInScaleAndRotateButton(x, y)) {
      // 开始进行单指旋转缩放
      _actionMode = DecorationActionMode.SINGER_FINGER_SCALE_AND_ROTATE;
      selectedDecorationElement.onSingleFingerScaleAndRotateStart();
      return true;
    }
    if (selectedDecorationElement.isInRemoveButton(x, y)) {
      _actionMode = DecorationActionMode.CLICK_BUTTON_DELETE;
      return true;
    }
    return false;
  }

  bool _upSelectTapOtherAction(
    PointerUpEvent event,
    Emitter<StickerContainerState> emit,
  ) {
    final selectedElement = _selectedElement;
    if (selectedElement == null) {
      return false;
    }

    DecorationElement selectedDecorationElement =
        selectedElement as DecorationElement;
    if (_actionMode == DecorationActionMode.CLICK_BUTTON_DELETE &&
        selectedDecorationElement.isInRemoveButton(
          // _getRelativeX(event.position.dx),
          // _getRelativeY(event.position.dy),
          _getRelativeX(event.localPosition.dx),
          _getRelativeY(event.localPosition.dy),
        )) {
      _unSelectDeleteAndUpdateTopElement(emit);
      _actionMode = DecorationActionMode.NONE;
      return true;
    }

    if (_actionMode == DecorationActionMode.SINGER_FINGER_SCALE_AND_ROTATE) {
      selectedDecorationElement.onSingleFingerScaleAndRotateEnd();
      _actionMode = DecorationActionMode.NONE;
      _update(emit);
      return true;
    }
    return false;
  }

  _unSelectDeleteAndUpdateTopElement(Emitter<StickerContainerState> emit) {
    _unSelectElement();
    _deleteElement();
    _update(emit);
  }

  bool _deleteElement([WsElement? wsElement]) {
    final elements = state.elements;
    if (wsElement == null) {
      if (elements.isEmpty) {
        return false;
      }
      wsElement = elements.first;
    }
    if (elements.first != wsElement) {
      return false;
    }
    elements.remove(wsElement);
    for (int i = 0; i < elements.length; i++) {
      WsElement nowElement = elements[i];
      nowElement.mZIndex--;
    }
    wsElement.delete();
    return true;
  }

  bool _scrollSelectTapOtherAction(
    List<DragUpdateDetails> dragUpdateDetails,
    Emitter<StickerContainerState> emit,
  ) {
    final selectedElement = _selectedElement;
    if (selectedElement == null) {
      return false;
    }
    if (_actionMode == DecorationActionMode.CLICK_BUTTON_DELETE) {
      return true;
    }
    if (_actionMode == DecorationActionMode.SINGER_FINGER_SCALE_AND_ROTATE) {
      DecorationElement selectedDecorationElement =
          selectedElement as DecorationElement;
      selectedDecorationElement.onSingleFingerScaleAndRotateProcess(
        // _getRelativeX(dragUpdateDetails[0].globalPosition.dx),
        // _getRelativeY(dragUpdateDetails[0].globalPosition.dy),
        _getRelativeX(dragUpdateDetails[0].localPosition.dx),
        _getRelativeY(dragUpdateDetails[0].localPosition.dy),
      );
      _update(emit);
      return true;
    }
    return false;
  }
}
