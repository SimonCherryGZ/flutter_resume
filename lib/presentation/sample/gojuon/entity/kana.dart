class Kana {
  Kana({
    required this.hiragana,
    required this.katakana,
    required this.romaji,
  });

  final String hiragana;
  final String katakana;
  final String romaji;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Kana &&
          runtimeType == other.runtimeType &&
          hiragana == other.hiragana &&
          katakana == other.katakana &&
          romaji == other.romaji;

  @override
  int get hashCode => hiragana.hashCode ^ katakana.hashCode ^ romaji.hashCode;
}
