import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class ComputeShowcaseWidget extends StatelessWidget {
  const ComputeShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return ShowcaseWidget(
      title: l10n.computeShowcaseTitle,
      content: l10n.computeShowcaseContent,
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
              child: Text(l10n.computeShowcaseButtonText),
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
