part of 'card_match_cubit.dart';

class CardMatchState {
  final int round;
  final List<Card> cards;
  final int score;
  final int combo;
  final Card? selectedCard;

  CardMatchState({
    this.round = 0,
    required this.cards,
    this.score = 0,
    this.combo = 0,
    this.selectedCard,
  });

  CardMatchState copyWith({
    int? round,
    List<Card>? cards,
    int? score,
    int? combo,
    Card? selectedCard,
  }) {
    return CardMatchState(
      round: round ?? this.round,
      cards: cards ?? this.cards,
      score: score ?? this.score,
      combo: combo ?? this.combo,
      selectedCard: selectedCard,
    );
  }
}
