import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_resume/presentation/welcome/welcome.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeAdView extends StatelessWidget {
  final SplashAd splashAd;

  const WelcomeAdView(
    this.splashAd, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final l10n = L10nDelegate.l10n(context);
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          CommonNetworkImage(
            imageUrl: splashAd.imageUrl,
            fadeInDuration: const Duration(milliseconds: 150),
            fadeOutDuration: const Duration(milliseconds: 150),
            fit: BoxFit.fill,
            width: screenSize.width,
            height: screenSize.height - 100.ss(),
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 10.ss(),
                  right: 10.ss(),
                  child: WelcomeAdSkipButton(
                    maxSecond: 10,
                    allowSkipSecond: 8,
                    clickSkipCallback: () {
                      debugPrint('点击跳过广告');
                      context.read<WelcomeBloc>().add(CloseAd());
                    },
                    showAdCompleteCallback: () {
                      debugPrint('广告完整显示完毕');
                      context.read<WelcomeBloc>().add(CloseAd());
                    },
                  ),
                ),
                Center(
                  child: WelcomeAdJumpButton(
                    buttonText: splashAd.buttonText,
                    clickJumpCallback: () {
                      // 模拟广告跳转
                      debugPrint('点击广告跳转按钮');
                      launchUrl(Uri.parse(splashAd.jumpContent));
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 100.ss(),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        l10n.splashAdTips,
                        style: TextStyle(
                          fontSize: 20.ss(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
