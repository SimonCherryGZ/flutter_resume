import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleNumberSpinnerScreen extends StatelessWidget {
  const SampleNumberSpinnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Spinner'),
      ),
      body: _SampleNumberSpinnerScreenContent(),
    );
  }
}

class _SampleNumberSpinnerScreenContent extends StatefulWidget {
  @override
  State<_SampleNumberSpinnerScreenContent> createState() =>
      _SampleNumberSpinnerScreenContentState();
}

class _SampleNumberSpinnerScreenContentState
    extends State<_SampleNumberSpinnerScreenContent> {
  final _numberSpinnerController = NumberSpinnerController();
  bool _playing = false;
  int _targetNumber = 777;
  late final Random _random;

  @override
  void initState() {
    super.initState();
    _random = Random();
  }

  @override
  Widget build(BuildContext context) {
    const numberTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 26,
      height: 30 / 26,
      color: Color(0xFFF8FF20),
      shadows: [
        Shadow(
          offset: Offset.zero,
          blurRadius: 4,
          color: Color(0xFFF8D355),
        ),
      ],
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: NumberSpinner(
              targetNumber: _targetNumber,
              showAnimation: true,
              controller: _numberSpinnerController,
              unitWidth: (numberTextStyle.fontSize ?? 0) * 0.65,
              unitHeight: (numberTextStyle.fontSize ?? 0) *
                  (numberTextStyle.height ?? 0),
              duration: const Duration(milliseconds: 1500),
              delayBetween: const Duration(milliseconds: 200),
              numberTextStyle: numberTextStyle,
              onCompleted: () {
                setState(() {
                  _playing = false;
                });
              },
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _playing
                    ? null
                    : () {
                        setState(() {
                          _playing = true;
                          _numberSpinnerController.reset();

                          _targetNumber = _random.nextInt(899) + 100;
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((_) {
                            if (mounted) {
                              _numberSpinnerController.forward();
                            }
                          });
                        });
                      },
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text('Spin'),
              ),
              const SizedBox(width: 50),
              ElevatedButton(
                onPressed: _playing
                    ? null
                    : () {
                        _numberSpinnerController.reset();
                      },
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
