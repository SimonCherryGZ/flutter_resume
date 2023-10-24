import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleAnimationScreen extends StatelessWidget {
  const SampleAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Sample'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimationControllerShowcaseWidget(),
              Divider(),
              ImplicitAnimationShowcaseWidget(),
              Divider(),
              CurveShowcaseWidget(),
              Divider(),
              HeroShowcaseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
