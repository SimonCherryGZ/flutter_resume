import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/isolate/isolate.dart';

class SampleIsolateScreen extends StatelessWidget {
  const SampleIsolateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IsolateRunShowcaseWidget(),
              Divider(),
              IsolateSpawnShowcaseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
