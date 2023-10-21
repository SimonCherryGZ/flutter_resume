import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class ComputeShowcaseWidget extends StatelessWidget {
  const ComputeShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: '新 isolate 中执行耗时操作',
      content: '点击【执行耗时操作】按钮，进度指示器不受影响',
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
    showToast('Heavy task processing...');
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    compute(_heavyTask, 455553000).then((result) {
      final cost = stopwatch.elapsedMilliseconds;
      showToast('Heavy task cost: $cost ms');
    });
  }

  int _heavyTask(int n) {
    int z = n;
    for (var i = 0; i < n; i++) {
      i % 2 == 0 ? z-- : z += 3;
    }
    return z + n;
  }
}
