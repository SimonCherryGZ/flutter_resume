import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class AnimationControllerShowcaseWidget extends StatefulWidget {
  const AnimationControllerShowcaseWidget({super.key});

  @override
  State<AnimationControllerShowcaseWidget> createState() =>
      _AnimationControllerShowcaseWidgetState();
}

class _AnimationControllerShowcaseWidgetState
    extends State<AnimationControllerShowcaseWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final StreamController<AnimationStatus> _streamController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _streamController = StreamController<AnimationStatus>.broadcast();

    _animationController.addStatusListener((status) {
      _streamController.add(status);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return ShowcaseWidget(
      title: l10n.animationControllerShowcaseTitle,
      content: l10n.animationControllerShowcaseContent,
      builder: (context) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  painter: DrawStarPainter(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 4.ss(),
                    progress: _animationController.view,
                  ),
                  size: Size(120.ss(), 120.ss()),
                ),
                StreamBuilder(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    final status = snapshot.data ?? AnimationStatus.dismissed;
                    final offstage = status != AnimationStatus.dismissed;
                    return Offstage(
                      offstage: offstage,
                      child: Text(
                        l10n.animationControllerShowcaseIdleHint,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 30.ss()),
            StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                final status = snapshot.data ?? AnimationStatus.dismissed;
                return Text(status.toString());
              },
            ),
            SizedBox(height: 10.ss()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.ss()),
              child: AnimatedBuilder(
                animation: _animationController.view,
                builder: (context, child) {
                  return Slider(
                    value: _animationController.value,
                    onChanged: (value) {
                      _animationController.value = value;
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 30.ss()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _animationController.reverse();
                  },
                  icon: Transform.scale(
                    scaleX: -1,
                    child: const Icon(
                      Icons.play_arrow,
                    ),
                  ),
                ),
                SizedBox(width: 20.ss()),
                IconButton(
                  onPressed: () {
                    _animationController.stop();
                  },
                  icon: const Icon(Icons.pause),
                ),
                SizedBox(width: 20.ss()),
                IconButton(
                  onPressed: () {
                    _animationController.forward();
                  },
                  icon: const Icon(Icons.play_arrow),
                ),
                SizedBox(width: 20.ss()),
                IconButton(
                  onPressed: () {
                    _animationController.reset();
                  },
                  icon: const Icon(Icons.stop),
                ),
                SizedBox(width: 20.ss()),
                IconButton(
                  onPressed: () {
                    _animationController.repeat();
                  },
                  icon: const Icon(Icons.repeat),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
