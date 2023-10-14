import 'package:flutter_resume/domain/domain.dart';

abstract class AdRepository {
  Future<SplashAd?> loadSplashAd();
}
