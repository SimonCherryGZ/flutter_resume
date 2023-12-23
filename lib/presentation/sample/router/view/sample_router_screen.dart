import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';

class SampleRouterScreen extends StatelessWidget {
  const SampleRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.sampleRouterScreenTitle),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ObserverShowcaseWidget(),
              Divider(),
              SubRoutesShowcaseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
