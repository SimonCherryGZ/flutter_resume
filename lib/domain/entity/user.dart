import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String nickname;
  final String email;
  final String avatar;

  User({
    required this.id,
    required this.nickname,
    required this.email,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
