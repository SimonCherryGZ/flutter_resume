import 'dart:math';

import 'package:flutter_resume/config/config.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/faker/data/data.dart';

const int _maxUserCount = 100;

class Faker {
  factory Faker(int seed) {
    _instance ??= Faker._(seed);
    return _instance!;
  }

  Faker._(int seed) : _random = Random(seed);

  static Faker? _instance;

  final Random _random;
  int _userIncrementIndex = 0;
  final List<User> _users = [];
  int _messageIncrementIndex = 0;
  int _conversationIncrementIndex = 0;

  int nextInt(int max) => _random.nextInt(max);

  User user() {
    if (_users.length >= _maxUserCount) {
      return _users[_random.nextInt(_maxUserCount)];
    }
    final name = nickname();
    const regex =
        r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';
    final nameWithoutSymbols =
        name.replaceAll(RegExp(regex, unicode: true), '');
    final email = '$nameWithoutSymbols@example.com';
    final avatar =
        'https://api.multiavatar.com/$nameWithoutSymbols.png?apikey=${BuildConfig.multiAvatarApiKey}';
    final user = User(
      id: (_userIncrementIndex++).toString(),
      nickname: name,
      email: email,
      avatar: avatar,
    );
    _users.add(user);
    return user;
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
        _random.nextInt(10) > 7 ? _random.nextInt(10) : 0,
        (_) => comment(),
      ),
    );
  }

  Message message(User currentUser, User otherUser) {
    final flag = _random.nextBool();
    return Message(
      id: (_messageIncrementIndex++).toString(),
      fromUser: flag ? currentUser : otherUser,
      toUser: flag ? otherUser : currentUser,
      content: content(),
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  Conversation conversation(User currentUser) {
    final otherUser = user();
    return Conversation(
      id: (_conversationIncrementIndex++).toString(),
      ownerId: currentUser.id,
      messages: List.generate(
        _random.nextInt(10) + 1,
        (_) => message(currentUser, otherUser),
      ),
    );
  }

  String imageUrl() {
    return _randomElement(imageUrls);
  }

  T _randomElement<T>(List<T> list) {
    return list[_random.nextInt(list.length)];
  }
}
