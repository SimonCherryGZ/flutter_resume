part of 'gojuon_bloc.dart';

abstract class GojuonEvent {}

class AskRandomKana extends GojuonEvent {}

class ClickAnswer extends GojuonEvent {
  final Kana answer;

  ClickAnswer(this.answer);
}

class SwitchAskMode extends GojuonEvent {}

class SwitchAskKanaType extends GojuonEvent {}

class UpdateSelectedRows extends GojuonEvent {
  final Map<int, bool> selectedRows;

  UpdateSelectedRows(this.selectedRows);
}
