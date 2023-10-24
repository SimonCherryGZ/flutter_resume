import 'dart:math';

import 'package:flutter_resume/config/config.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/faker/data/data.dart';

class Faker {
  factory Faker(int seed) {
    _instance ??= Faker._(seed);
    return _instance!;
  }

  Faker._(int seed) : _random = Random(seed);

  static Faker? _instance;

  final Random _random;
  int _incrementIndex = 0;

  int nextInt(int max) => _random.nextInt(max);

  User user() {
    final name = nickname();
    const regex =
        r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';
    final nameWithoutSymbols =
        name.replaceAll(RegExp(regex, unicode: true), '');
    final email = '$nameWithoutSymbols@example.com';
    final avatar =
        'https://api.multiavatar.com/$nameWithoutSymbols.png?apikey=${BuildConfig.multiAvatarApiKey}';
    return User(
      id: (_incrementIndex++).toString(),
      nickname: name,
      email: email,
      avatar: avatar,
    );
  }

  String nickname() {
    final flag = _random.nextBool();
    String name =
        flag ? _randomElement(englishNames) : _randomElement(chineseNames);
    String pattern = _randomElement(nicknamePattern);
    return pattern.replaceAll('@', name);
  }

  String title() => _randomElement(titles);

  String content() => _randomElement(contents);

  Comment comment() {
    return Comment(
      author: user(),
      content: _randomElement(comments),
      replies: List.generate(
        _random.nextInt(10) > 7 ? _random.nextInt(3) : 0,
        (_) => comment(),
      ),
    );
  }

  T _randomElement<T>(List<T> list) {
    return list[_random.nextInt(list.length)];
  }
}
