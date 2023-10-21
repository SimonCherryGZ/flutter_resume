import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class IOTaskShowcaseWidget extends StatelessWidget {
  const IOTaskShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'I/O 操作',
      content: 'I/O 操作在 IO Task Runner 执行，不阻塞 UI',
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
                _executeIOTask();
              },
              child: const Text('执行 I/O 操作'),
            ),
          ],
        );
      },
    );
  }

  void _executeIOTask() async {
    showToast('I/O task processing...');
    final cost = await _ioTask();
    showToast('I/O task cost: $cost ms');
  }

  Future<int> _ioTask() async {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    await Future.wait([
      HttpUtil().get('http://www.baidu.com/'),
      HttpUtil().get('http://www.bing.com/'),
      HttpUtil().get('http://www.sogou.com/'),
    ]);
    return stopwatch.elapsedMilliseconds;
  }
}
