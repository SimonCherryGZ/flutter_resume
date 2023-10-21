import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class BlockUIShowcaseWidget extends StatelessWidget {
  const BlockUIShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'UI Task Runner 执行耗时操作',
      content: '点击【执行耗时操作】按钮，观察进度指示器卡顿',
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              width: 80.ss(),
              height: 80.ss(),
              child: const CircularProgressIndicator(),
            ),
            SizedBox(height: 50.ss()),
            ElevatedButton(
              onPressed: () {
                _executeHeavyTask();
              },
              child: const Text('执行耗时操作'),
            ),
          ],
        );
      },
    );
  }

  void _executeHeavyTask() {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    _heavyTask(455553000);
    final cost = stopwatch.elapsedMilliseconds;
    showToast('Heavy task cost: $cost ms');
  }

  int _heavyTask(int n) {
    int z = n;
    for (var i = 0; i < n; i++) {
      i % 2 == 0 ? z-- : z += 3;
    }
    return z + n;
  }
}
