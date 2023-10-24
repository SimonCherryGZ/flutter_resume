import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class SampleHeroAnimationScreen extends StatelessWidget {
  const SampleHeroAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'hero',
              child: CircleDashWidget(
                width: screenSize.width * 0.6,
                height: screenSize.width * 0.6,
              ),
            ),
            SizedBox(height: 30.ss()),
            Text(
              'Hello Dash Hero!',
              style: TextStyle(
                fontSize: 30.ss(),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
