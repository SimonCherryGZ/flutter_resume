import 'package:flutter_resume/domain/domain.dart';

abstract class UserRepository {
  Future<User?> login({
    required String account,
    required String password,
  });

  Future<bool> logout();

  Future<User?> loadSignedUser();

  Future<void> saveSignedUser(User? user);

  Future<void> clearSignedUser();
}
