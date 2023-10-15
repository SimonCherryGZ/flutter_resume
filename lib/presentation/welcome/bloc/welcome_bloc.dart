import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/app/app.dart';

part 'welcome_event.dart';

part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final AppCubit _appCubit;
  final AdRepository _adRepository;

  WelcomeBloc(
    this._appCubit,
    this._adRepository,
  ) : super(WelcomeState.initial()) {
    on<LoadAd>(_onLoadAd);
    on<CloseAd>(_onCloseAd);
  }

  void _onLoadAd(LoadAd event, Emitter<WelcomeState> emit) async {
    // 模拟加载Ad
    Completer<SplashAd?> completer = Completer();
    _adRepository.loadSplashAd().then(
      (value) {
        if (!completer.isCompleted) {
          debugPrint('SplashAd loaded');
          completer.complete(value);
        }
      },
      onError: (object, stackTrace) {
        if (!completer.isCompleted) {
          debugPrint('SplashAd load failed: $stackTrace');
          completer.complete(null);
        }
      },
    );
    // 只给 3 秒时间加载，超时就当加载失败
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (!completer.isCompleted) {
        debugPrint('SplashAd load timeout');
        completer.complete(null);
      }
    });
    // 加载过程中，顺便初始化用户数据
    // Dart Future.wait for multiple futures and get back results of different types
    // https://stackoverflow.com/a/71178612
    final (_, splashAd) = await (
      _appCubit.init(),
      completer.future,
    ).wait;
    if (splashAd == null) {
      emit(state.copyWith(adStatus: WelcomeAdStatus.failed));
      return;
    }
    emit(state.copyWith(
      splashAd: splashAd,
      adStatus: WelcomeAdStatus.loaded,
    ));
  }

  void _onCloseAd(CloseAd event, Emitter<WelcomeState> emit) async {
    emit(state.copyWith(adStatus: WelcomeAdStatus.closed));
  }
}
