import 'dart:math';

import 'package:flutter_resume/presentation/sample/card_match/entity/card.dart';

final suits = [
  'diamonds',
  'clubs',
  'hearts',
  'spades',
];
final ranks = [
  'ace',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  'jack',
  'queen',
  'king',
];

final _random = Random();

class Deck {
  final List<Card> cards = [];
  final bool withJoker;

  Deck({
    this.withJoker = false,
  }) {
    reset();
  }

  void reset() {
    cards.clear();
    for (final suit in suits) {
      for (final rank in ranks) {
        cards.add(Card(suit: suit, rank: rank));
      }
    }
    if (withJoker) {
      cards.add(Card(suit: 'black', rank: 'joker'));
      cards.add(Card(suit: 'red', rank: 'joker'));
    }
  }

  Card drawRandomCard() {
    return cards.removeAt(_random.nextInt(cards.length));
  }
}
