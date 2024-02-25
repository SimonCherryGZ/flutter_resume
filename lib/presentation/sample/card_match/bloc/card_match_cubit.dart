import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_resume/presentation/sample/card_match/entity/entity.dart';

part 'card_match_state.dart';

class CardMatchCubit extends Cubit<CardMatchState> {
  CardMatchCubit() : super(CardMatchState(cards: []));

  final _deck = Deck();
  final _random = Random();
  Completer<bool>? _matchCompleter;

  void init() {
    _matchCompleter?.complete(false);
    _matchCompleter = null;

    final List<Card> tempCards = [];
    for (int i = 0; i < 8; i++) {
      final card = _deck.drawRandomCard();
      tempCards.add(card);
      tempCards.add(Card(suit: card.suit, rank: card.rank));
    }
    final cards = state.cards;
    cards.clear();
    for (int i = 0; i < 16; i++) {
      cards.add(tempCards.removeAt(_random.nextInt(tempCards.length)));
    }
    emit(state.copyWith(
      round: state.round + 1,
      cards: cards,
      score: 0,
      combo: 0,
      selectedCard: null,
    ));
  }

  FutureOr<bool> selectCard(Card card) {
    final lastSelectedCard = state.selectedCard;
    final currentSelectedCard = card;
    if (lastSelectedCard == null) {
      emit(state.copyWith(selectedCard: currentSelectedCard));
      _matchCompleter?.complete(false);
      _matchCompleter = Completer();
      return _matchCompleter!.future;
    }
    final score = state.score;
    final combo = state.combo;
    if (lastSelectedCard == currentSelectedCard) {
      _matchCompleter?.complete(true);
      _matchCompleter = null;
      emit(state.copyWith(
        score: score + combo + 4,
        combo: combo + 1,
        selectedCard: null,
      ));
      return true;
    } else {
      _matchCompleter?.complete(false);
      _matchCompleter = null;
      emit(state.copyWith(
        score: score - 1,
        combo: 0,
        selectedCard: null,
      ));
      return false;
    }
  }
}
