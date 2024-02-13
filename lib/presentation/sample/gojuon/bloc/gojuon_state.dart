part of 'gojuon_bloc.dart';

class GojuonState {
  final Kana kana;
  final List<Kana> optionAnswers;
  final List<Kana> wrongAnswers;
  final bool isAskRomaji;
  final KanaType kanaType;
  final Map<int, bool> selectedRows;

  GojuonState({
    required this.kana,
    required this.optionAnswers,
    required this.wrongAnswers,
    required this.isAskRomaji,
    required this.kanaType,
    required this.selectedRows,
  });

  GojuonState.none()
      : kana = Kana(hiragana: 'あ', katakana: 'ア', romaji: 'a'),
        optionAnswers = [],
        wrongAnswers = [],
        isAskRomaji = false,
        kanaType = KanaType.hiragana,
        selectedRows = {0: true};

  GojuonState copyWith({
    Kana? kana,
    List<Kana>? optionAnswers,
    List<Kana>? wrongAnswers,
    bool? isAskRomaji,
    KanaType? kanaType,
    Map<int, bool>? selectedRows,
  }) {
    return GojuonState(
      kana: kana ?? this.kana,
      optionAnswers: optionAnswers ?? this.optionAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      isAskRomaji: isAskRomaji ?? this.isAskRomaji,
      kanaType: kanaType ?? this.kanaType,
      selectedRows: selectedRows ?? this.selectedRows,
    );
  }
}
