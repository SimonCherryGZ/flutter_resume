import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class WelcomeAdSkipButton extends StatefulWidget {
  final int maxSecond;
  final int allowSkipSecond;
  final VoidCallback? clickSkipCallback;
  final VoidCallback? showAdCompleteCallback;

  const WelcomeAdSkipButton({
    super.key,
    required this.maxSecond,
    required this.allowSkipSecond,
    this.clickSkipCallback,
    this.showAdCompleteCallback,
  });

  @override
  State<WelcomeAdSkipButton> createState() => _WelcomeAdSkipButtonState();
}

class _WelcomeAdSkipButtonState extends State<WelcomeAdSkipButton> {
  Stream<int>? _counterStream;
  StreamSubscription<int>? _counterSubscription;

  @override
  void initState() {
    super.initState();
    _counterStream = timedCounter(const Duration(seconds: 1), widget.maxSecond)
        .asBroadcastStream();
    _counterSubscription = _counterStream?.listen((counter) {
      final remainSecond = widget.maxSecond - counter;
      if (remainSecond == 0) {
        widget.showAdCompleteCallback?.call();
      }
    });
  }

  @override
  void dispose() {
    _counterSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.ss(),
      height: 30.ss(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.ss())),
        color: Colors.black.withOpacity(0.5),
      ),
      child: StreamBuilder(
        stream: _counterStream,
        initialData: 0,
        builder: (context, snapshot) {
          final counter = snapshot.data;
          if (counter == null) {
            return const SizedBox.shrink();
          }
          final remainSecond = widget.maxSecond - counter;
          final showSkip = remainSecond <= widget.allowSkipSecond;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (!showSkip) return;
              widget.clickSkipCallback?.call();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showSkip) ...[
                  Text(
                    '跳过',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.ss(),
                    ),
                  ),
                ],
                if (remainSecond >= 0 && showSkip) ...[
                  SizedBox(width: 5.ss()),
                ],
                if (remainSecond > 0) ...[
                  Text(
                    '$remainSecond S',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.ss(),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
