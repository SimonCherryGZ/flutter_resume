import 'dart:math';

import 'package:flutter_resume/domain/domain.dart';

class AdRepositoryImpl implements AdRepository {
  @override
  Future<SplashAd?> loadSplashAd() async {
    // 模拟加载，随机 1~4秒；开屏广告只等待 3 秒加载，超时跳过
    final random = Random();
    await Future.delayed(Duration(seconds: random.nextInt(4) + 1));
    return SplashAd(
      imageUrl:
          'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAOEcdM.img',
      buttonText: '立即抢购',
      jumpContent: 'https://www.bing.com/',
    );
  }
}
