import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/app_lifecycle/app_lifecycle.dart';

class SampleAppLifecycleScreen extends StatelessWidget {
  const SampleAppLifecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Lifecycle'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLifecycleListenerShowcaseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
