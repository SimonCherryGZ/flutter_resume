import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleAsyncScreen extends StatelessWidget {
  const SampleAsyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.sampleAsyncScreenTitle),
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
