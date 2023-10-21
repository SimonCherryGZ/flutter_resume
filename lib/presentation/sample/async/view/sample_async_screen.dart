import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleAsyncScreen extends StatelessWidget {
  const SampleAsyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Sample'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlockUIShowcaseWidget(),
              Divider(),
              ComputeShowcaseWidget(),
              Divider(),
              IOTaskShowcaseWidget(),
              Divider(),
              SerialTaskShowcaseWidget(),
              Divider(),
              ParallelTaskShowcaseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
