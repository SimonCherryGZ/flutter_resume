import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleLayoutScreen extends StatelessWidget {
  const SampleLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizeProblemShowcaseWidget(),
              Divider(),
              FixSizeProblemShowcaseWidget(),
              Divider(),
              ConstraintsProblemShowcaseWidget(),
              Divider(),
              FixConstraintsProblemShowcaseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
