import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_resume/welcome/welcome.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeAdView extends StatelessWidget {
  final ByteData adImageBytes;

  const WelcomeAdView(
    this.adImageBytes, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Image.memory(
          Uint8List.view(adImageBytes.buffer),
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
                  clickJumpCallback: () {
                    // 模拟广告跳转
                    debugPrint('点击广告跳转按钮');
                    launchUrl(Uri.parse('https://www.bing.com/'));
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
                      '假装这是开屏广告',
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
    );
  }
}
