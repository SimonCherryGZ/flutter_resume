import 'dart:convert';

import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/utils/utils.dart';

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

  @override
  Future<User?> loadSignedUser() async {
    final sp = await SpUtil.getInstance();
    final json = sp.getString('user');
    final user = null == json ? null : User.fromJson(jsonDecode(json));
    return user;
  }

  @override
  Future<void> saveSignedUser(User? user) async {
    final sp = await SpUtil.getInstance();
    if (user == null) {
      await sp.remove('user');
      return;
    }
    await sp.putString('user', jsonEncode(user.toJson()));
  }
}
