import 'dart:math';

import 'kana.dart';

class Gojuon {
  List<Kana> get kanaList => _kanaList;

  final List<Kana> _kanaList = [];
  final Random _random = Random();

  Gojuon() {
    // a
    _kanaList.add(Kana(hiragana: 'あ', katakana: 'ア', romaji: 'a'));
    _kanaList.add(Kana(hiragana: 'い', katakana: 'イ', romaji: 'i'));
    _kanaList.add(Kana(hiragana: 'う', katakana: 'ウ', romaji: 'u'));
    _kanaList.add(Kana(hiragana: 'え', katakana: 'エ', romaji: 'e'));
    _kanaList.add(Kana(hiragana: 'お', katakana: 'オ', romaji: 'o'));
    // ka
    _kanaList.add(Kana(hiragana: 'か', katakana: 'カ', romaji: 'ka'));
    _kanaList.add(Kana(hiragana: 'き', katakana: 'キ', romaji: 'ki'));
    _kanaList.add(Kana(hiragana: 'く', katakana: 'ク', romaji: 'ku'));
    _kanaList.add(Kana(hiragana: 'け', katakana: 'ケ', romaji: 'ke'));
    _kanaList.add(Kana(hiragana: 'こ', katakana: 'コ', romaji: 'ko'));
    // sa
    _kanaList.add(Kana(hiragana: 'さ', katakana: 'サ', romaji: 'sa'));
    _kanaList.add(Kana(hiragana: 'し', katakana: 'シ', romaji: 'shi'));
    _kanaList.add(Kana(hiragana: 'す', katakana: 'ス', romaji: 'su'));
    _kanaList.add(Kana(hiragana: 'せ', katakana: 'セ', romaji: 'se'));
    _kanaList.add(Kana(hiragana: 'そ', katakana: 'ソ', romaji: 'so'));
    // ta
    _kanaList.add(Kana(hiragana: 'た', katakana: 'タ', romaji: 'ta'));
    _kanaList.add(Kana(hiragana: 'ち', katakana: 'チ', romaji: 'chi'));
    _kanaList.add(Kana(hiragana: 'つ', katakana: 'ツ', romaji: 'tsu'));
    _kanaList.add(Kana(hiragana: 'て', katakana: 'テ', romaji: 'te'));
    _kanaList.add(Kana(hiragana: 'と', katakana: 'ト', romaji: 'to'));
    // na
    _kanaList.add(Kana(hiragana: 'な', katakana: 'ナ', romaji: 'na'));
    _kanaList.add(Kana(hiragana: 'に', katakana: 'ニ', romaji: 'ni'));
    _kanaList.add(Kana(hiragana: 'ぬ', katakana: 'ヌ', romaji: 'nu'));
    _kanaList.add(Kana(hiragana: 'ね', katakana: 'ネ', romaji: 'ne'));
    _kanaList.add(Kana(hiragana: 'の', katakana: 'ノ', romaji: 'no'));
    // ha
    _kanaList.add(Kana(hiragana: 'は', katakana: 'ハ', romaji: 'ha'));
    _kanaList.add(Kana(hiragana: 'ひ', katakana: 'ヒ', romaji: 'hi'));
    _kanaList.add(Kana(hiragana: 'ふ', katakana: 'フ', romaji: 'fu'));
    _kanaList.add(Kana(hiragana: 'へ', katakana: 'ヘ', romaji: 'he'));
    _kanaList.add(Kana(hiragana: 'ほ', katakana: 'ホ', romaji: 'ho'));
    // ma
    _kanaList.add(Kana(hiragana: 'ま', katakana: 'マ', romaji: 'ma'));
    _kanaList.add(Kana(hiragana: 'み', katakana: 'ミ', romaji: 'mi'));
    _kanaList.add(Kana(hiragana: 'む', katakana: 'ム', romaji: 'mu'));
    _kanaList.add(Kana(hiragana: 'め', katakana: 'メ', romaji: 'me'));
    _kanaList.add(Kana(hiragana: 'も', katakana: 'モ', romaji: 'mo'));
    // ya
    _kanaList.add(Kana(hiragana: 'や', katakana: 'ヤ', romaji: 'ya'));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
    _kanaList.add(Kana(hiragana: 'ゆ', katakana: 'ユ', romaji: 'yu'));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
    _kanaList.add(Kana(hiragana: 'よ', katakana: 'ヨ', romaji: 'yo'));
    // ra
    _kanaList.add(Kana(hiragana: 'ら', katakana: 'ラ', romaji: 'ra'));
    _kanaList.add(Kana(hiragana: 'り', katakana: 'リ', romaji: 'ri'));
    _kanaList.add(Kana(hiragana: 'る', katakana: 'ル', romaji: 'ru'));
    _kanaList.add(Kana(hiragana: 'れ', katakana: 'レ', romaji: 're'));
    _kanaList.add(Kana(hiragana: 'ろ', katakana: 'ロ', romaji: 'ro'));
    // wa
    _kanaList.add(Kana(hiragana: 'わ', katakana: 'ワ', romaji: 'wa'));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
    _kanaList.add(Kana(hiragana: 'を', katakana: 'ヲ', romaji: 'wo'));
    // n
    _kanaList.add(Kana(hiragana: 'ん', katakana: 'ン', romaji: 'n'));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
    _kanaList.add(Kana(hiragana: '', katakana: '', romaji: ''));
  }

  List<Kana> getKanaListInRow(int row) {
    final List<Kana> subList = [];
    for (int i = 0; i < 5; i++) {
      subList.add(_kanaList[row * 5 + i]);
    }
    return subList;
  }

  Kana getRandomKanaInRow(int row) {
    int index = _random.nextInt(10000) % 5;
    return _kanaList[row * 5 + index];
  }

  Kana getRandomKana() {
    int index = _random.nextInt(10000) % _kanaList.length;
    return _kanaList[index];
  }
}
