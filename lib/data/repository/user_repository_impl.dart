import 'package:flutter_resume/domain/domain.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User?> login({
    required String account,
    required String password,
  }) async {
    // 模拟登录
    await Future.delayed(const Duration(seconds: 2));
    return User(
      id: '1024',
      nickname: account,
      email: '$account@example.com',
    );
  }
}
