import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class SampleSubRouteScreen extends StatelessWidget {
  const SampleSubRouteScreen({
    super.key,
    required this.label,
    this.nextRoutePath,
  });

  final String label;
  final String? nextRoutePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SubRoute - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('模拟子路由页面 $label'),
            SizedBox(height: 50.ss()),
            Icon(
              switch (label) {
                'B' => Icons.android,
                'C' => Icons.cake,
                'D' => Icons.coffee,
                _ => Icons.flutter_dash,
              },
              size: 100.ss(),
            ),
            SizedBox(height: 50.ss()),
            if (nextRoutePath != null) ...[
              ElevatedButton(
                onPressed: () {
                  context.goNamed(nextRoutePath!);
                },
                child: const Text('Next'),
              ),
            ],
            if (nextRoutePath == null) ...[
              ElevatedButton(
                onPressed: () {
                  context.goNamed(AppRouter.sampleRouter);
                },
                child: const Text('返回 Router Sample'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
