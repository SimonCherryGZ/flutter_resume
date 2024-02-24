import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/custom_layout/custom_layout.dart';
import 'package:flutter_resume/utils/utils.dart';

class SampleCustomLayoutScreen extends StatelessWidget {
  const SampleCustomLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Layout'),
      ),
      body: Center(
        child: _SampleCustomLayoutScreenContent(),
      ),
    );
  }
}

class _SampleCustomLayoutScreenContent extends StatefulWidget {
  @override
  State<_SampleCustomLayoutScreenContent> createState() =>
      _SampleCustomLayoutScreenContentState();
}

class _SampleCustomLayoutScreenContentState
    extends State<_SampleCustomLayoutScreenContent> {
  int _childCount = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleLayoutWidget(
          layoutSize: 200.ss(),
          children: List.generate(_childCount, (index) => index)
              .map((e) => _ChildWidget(e))
              .toList(),
        ),
        SizedBox(height: 100.ss()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _childCount--;
                  _childCount = max(0, _childCount);
                });
              },
              child: const Text('减少'),
            ),
            SizedBox(width: 50.ss()),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _childCount++;
                });
              },
              child: const Text('增加'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ChildWidget extends StatelessWidget {
  const _ChildWidget(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 30.ss(),
        height: 30.ss(),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
