import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class IsolateRunShowcaseWidget extends StatelessWidget {
  const IsolateRunShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'Isolate.run',
      content: 'Short-lived isolates',
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
              child: const Text('Run task in isolate'),
            ),
          ],
        );
      },
    );
  }

  void _executeHeavyTask() {
    showToast('Heavy task processing...');
    Isolate.run<int>(() {
      return _heavyTask(455553000);
    }).then((result) {
      showToast('Heavy task result: $result');
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
