import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:ui' as ui;

part 'editor_event.dart';

part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc({
    required this.canvasKey,
  }) : super(EditorState()) {
    on<AddAssetSticker>((event, emit) {
      emit(EditorState(
        imagePath: event.imagePath,
        width: event.width,
        height: event.height,
      ));
    });
    on<ExportImage>(_onExportImage);
  }

  final GlobalKey canvasKey;

  void _onExportImage(ExportImage event, Emitter<EditorState> emit) async {
    emit(state.copyWith(isShowLoading: true));
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
      emit(state.copyWith(isShowLoading: false));
      showToast('未授予相册权限');
      return;
    }
    RenderRepaintBoundary? boundary =
        canvasKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(
        pixelRatio: ScreenUtil.getInstance().screenDensity);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List bytes = byteData!.buffer.asUint8List();
    final title = DateTime.now().millisecondsSinceEpoch.toString();
    final entity = await PhotoManager.editor.saveImage(
      bytes,
      title: title,
    );
    emit(state.copyWith(isShowLoading: false));
    showToast(
        entity != null ? '已保存到 ${entity.relativePath}/$title.jpg' : '保存失败');
  }
}
