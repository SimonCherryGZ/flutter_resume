import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

typedef OnMatch = Future<bool> Function();

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.assetName,
    required this.onMatch,
  });

  final String assetName;
  final OnMatch onMatch;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late final ImageProvider _backImage;
  late final ImageProvider _frontImage;
  late final AnimationController _animationController;
  bool _isFrontFace = false;
  bool _isMatched = false;
  bool _isWaitMatchResult = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _backImage = const AssetImage('assets/images/card/card_back.png');
    _frontImage = AssetImage('assets/images/card/${widget.assetName}.png');

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.addStatusListener((status) async {
      if (_isDisposed) {
        return;
      }
      if (status == AnimationStatus.completed) {
        _isWaitMatchResult = true;
        _isMatched = await widget.onMatch.call();
        if (!_isMatched) {
          _isWaitMatchResult = false;
          _flipCard(false);
        }
      }
    });
    _animationController.addListener(() {
      if (_isDisposed) {
        return;
      }
      final progress = _animationController.value;
      if (progress >= 0.5 && !_isFrontFace || progress < 0.5 && _isFrontFace) {
        setState(() {
          _isFrontFace = _animationController.status == AnimationStatus.forward;
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isMatched || _isWaitMatchResult || _isDisposed) {
          return;
        }
        if (_animationController.isAnimating) {
          return;
        }
        _flipCard(true);
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(pi * (1 - _animationController.value)),
            transformAlignment: Alignment.center,
            child: child,
          );
        },
        child: _CardContent(_isFrontFace ? _frontImage : _backImage),
      ),
    );
  }

  void _flipCard(bool toFrontFace) {
    if (_isDisposed) {
      return;
    }
    if (toFrontFace && _animationController.isDismissed) {
      _animationController.forward();
    } else if (!toFrontFace && _animationController.isCompleted) {
      _animationController.reverse();
    }
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent(this.image);

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.ss(),
        vertical: 3.ss(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.ss())),
        color: Colors.white,
      ),
      child: Image(
        image: image,
        fit: BoxFit.contain,
      ),
    );
  }
}
