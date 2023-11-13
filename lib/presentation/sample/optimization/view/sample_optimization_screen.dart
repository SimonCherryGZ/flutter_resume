import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleOptimizationScreen extends StatefulWidget {
  const SampleOptimizationScreen({super.key});

  @override
  State<SampleOptimizationScreen> createState() =>
      _SampleOptimizationScreenState();
}

class _SampleOptimizationScreenState extends State<SampleOptimizationScreen> {
  bool _shouldScroll = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Optimization'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: _shouldScroll ? null : const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundaryShowcaseWidget(
                repaintBoundaryEnable: false,
                onPanDown: () {
                  setState(() {
                    _shouldScroll = false;
                  });
                },
                onPanEnd: () {
                  setState(() {
                    _shouldScroll = true;
                  });
                },
              ),
              const Divider(),
              RepaintBoundaryShowcaseWidget(
                repaintBoundaryEnable: true,
                onPanDown: () {
                  setState(() {
                    _shouldScroll = false;
                  });
                },
                onPanEnd: () {
                  setState(() {
                    _shouldScroll = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
