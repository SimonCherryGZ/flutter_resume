import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

part 'welcome_event.dart';

part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState.initial()) {
    on<LoadAd>(_onLoadAd);
    on<CloseAd>(_onCloseAd);
  }

  void _onLoadAd(LoadAd event, Emitter<WelcomeState> emit) async {
    // 模拟加载Ad；这里只是加载一张在线图片
    Completer<ui.Image?> completer = Completer();
    const NetworkImage(
            'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAOEcdM.img')
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener(
          (imageInfo, synchronousCall) {
            debugPrint('WelcomeAdImage loaded');
            if (!completer.isCompleted) {
              completer.complete(imageInfo.image);
            }
          },
          onError: (object, stackTrace) {
            debugPrint('WelcomeAdImage load failed: $stackTrace');
            if (!completer.isCompleted) {
              completer.complete(null);
            }
          },
        ));
    // 只给 3 秒时间加载，超时就当加载失败
    Future.delayed(const Duration(seconds: 10)).then((_) {
      debugPrint('WelcomeAdImage load timeout');
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    });

    final adImage = await completer.future;
    if (adImage == null) {
      emit(state.copyWith(adStatus: WelcomeAdStatus.failed));
      return;
    }
    final adImageBytes =
        await adImage.toByteData(format: ui.ImageByteFormat.png);
    emit(state.copyWith(
      adImageBytes: adImageBytes,
      adStatus: WelcomeAdStatus.loaded,
    ));
  }

  void _onCloseAd(CloseAd event, Emitter<WelcomeState> emit) async {
    emit(state.copyWith(adStatus: WelcomeAdStatus.closed));
  }
}
