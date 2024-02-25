class Card {
  final String suit;
  final String rank;

  Card({
    required this.suit,
    required this.rank,
  });

  String get assetName {
    if ('joker' == rank) {
      return '${rank}_$suit';
    }
    return '${rank}_of_$suit';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Card &&
          runtimeType == other.runtimeType &&
          suit == other.suit &&
          rank == other.rank;

  @override
  int get hashCode => suit.hashCode ^ rank.hashCode;
}
