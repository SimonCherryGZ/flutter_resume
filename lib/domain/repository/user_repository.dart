import 'package:flutter_resume/domain/domain.dart';

abstract class UserRepository {
  Future<User?> login({
    required String account,
    required String password,
  });
}
