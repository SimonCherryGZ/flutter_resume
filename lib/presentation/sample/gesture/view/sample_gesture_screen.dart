import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/gesture/gesture.dart';

class SampleGestureScreen extends StatelessWidget {
  const SampleGestureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HitTestBehaviourShowcaseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
