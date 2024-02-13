import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/gojuon/gojuon.dart';

part 'gojuon_event.dart';

part 'gojuon_state.dart';

class GojuonBloc extends Bloc<GojuonEvent, GojuonState> {
  static GojuonBloc of(BuildContext context) {
    return BlocProvider.of<GojuonBloc>(context);
  }

  static const int kItemCount = 4;

  final Gojuon _gojuon;
  final Random _random;

  GojuonBloc()
      : _gojuon = Gojuon(),
        _random = Random(),
        super(GojuonState.none()) {
    on<AskRandomKana>(_onAskRandomKana);
    on<ClickAnswer>(_onClickAnswer);
    on<SwitchAskMode>(_onSwitchAskMode);
    on<SwitchAskKanaType>(_onSwitchAskKanaType);
    on<UpdateSelectedRows>(_onUpdateSelectedRows);
  }

  Gojuon get gojuon => _gojuon;

  int getRandomValue() {
    return _random.nextInt(10000);
  }

  bool isWrongAnswer(Kana answer) {
    final wrongAnswers = state.wrongAnswers;
    for (Kana wrongAnswer in wrongAnswers) {
      if (wrongAnswer == answer) {
        return true;
      }
    }
    return false;
  }

  void _onAskRandomKana(AskRandomKana event, Emitter<GojuonState> emit) {
    // 从指定的多个行中，随机获取一个假名
    int row = 0;
    final selectedRow = state.selectedRows;
    bool onlyN = selectedRow.length == 1 && selectedRow.keys.elementAt(0) == 10;
    bool shouldRetry = false;
    final lastKana = state.kana;
    Kana currentKana;
    do {
      row = _getRandomRowInRows(selectedRow);
      currentKana = _gojuon.getRandomKanaInRow(row);
      bool sameKana = ((currentKana == lastKana) && !onlyN);
      bool placeholderKana = currentKana.hiragana.isEmpty;
      shouldRetry = sameKana || placeholderKana;
    } while (shouldRetry);

    // 获取指定的多个行的所有假名
    final List<Kana> kanaList = [];
    for (int i = 0; i < selectedRow.length; i++) {
      int row = selectedRow.keys.elementAt(i);
      final tempList = _gojuon.getKanaListInRow(row);
      for (final kana in tempList) {
        if (kana.hiragana.isEmpty) {
          continue;
        }
        kanaList.add(kana);
      }
    }

    // 除正确答案外，从指定的多个行随机添加几个备选答案
    final List<Kana> answers = [];
    int itemCount =
        kanaList.length >= kItemCount ? kItemCount : kanaList.length;
    int answerIndex = getRandomValue() % itemCount;
    for (int i = 0; i < itemCount;) {
      if (i == answerIndex) {
        answers.add(currentKana);
        i++;
        continue;
      }
      int index = getRandomValue() % kanaList.length;
      final kana = kanaList[index];
      if (kana == currentKana) {
        continue;
      }
      answers.add(kana);
      kanaList.removeAt(index);
      i++;
    }

    emit(state.copyWith(
      kana: currentKana,
      optionAnswers: answers,
      wrongAnswers: [],
    ));
  }

  int _getRandomRowInRows(Map<int, bool> rows) {
    int rowIndex = getRandomValue() % rows.length;
    return rows.keys.elementAt(rowIndex);
  }

  void _onClickAnswer(ClickAnswer event, Emitter<GojuonState> emit) {
    final answer = event.answer;
    final kana = state.kana;
    final correct = answer == kana;
    if (correct) {
      add(AskRandomKana());
      return;
    }
    if (state.wrongAnswers.contains(answer)) {
      return;
    }
    final List<Kana> wrongAnswers = [];
    wrongAnswers.addAll(state.wrongAnswers);
    wrongAnswers.add(answer);
    emit(state.copyWith(wrongAnswers: wrongAnswers));
  }

  void _onSwitchAskMode(SwitchAskMode event, Emitter<GojuonState> emit) {
    final isAskRomaji = state.isAskRomaji;
    emit(state.copyWith(isAskRomaji: !isAskRomaji));
  }

  void _onSwitchAskKanaType(
      SwitchAskKanaType event, Emitter<GojuonState> emit) {
    KanaType kanaType = state.kanaType;
    int index = KanaType.values.indexOf(kanaType);
    index++;
    if (index >= KanaType.values.length) {
      index = 0;
    }
    kanaType = KanaType.values.elementAt(index);
    emit(state.copyWith(kanaType: kanaType));
  }

  void _onUpdateSelectedRows(
      UpdateSelectedRows event, Emitter<GojuonState> emit) {
    final Map<int, bool> selectedRows = {};
    selectedRows.addAll(event.selectedRows);
    emit(state.copyWith(selectedRows: selectedRows));
    add(AskRandomKana());
  }
}
