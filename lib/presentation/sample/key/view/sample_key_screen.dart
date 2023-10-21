import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleKeyScreen extends StatelessWidget {
  const SampleKeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Sample'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SwapStatelessShowcaseWidget(),
              const Divider(),
              const SwapStatefulShowcaseWidget(useKey: false),
              const Divider(),
              const SwapStatefulShowcaseWidget(useKey: true),
              const Divider(),
              GlobalKeyShowcaseWidget(globalKey: GlobalKey()),
            ],
          ),
        ),
      ),
    );
  }
}
