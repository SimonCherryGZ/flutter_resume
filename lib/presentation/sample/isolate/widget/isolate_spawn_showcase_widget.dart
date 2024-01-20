import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class IsolateSpawnShowcaseWidget extends StatefulWidget {
  const IsolateSpawnShowcaseWidget({super.key});

  @override
  State<IsolateSpawnShowcaseWidget> createState() =>
      _IsolateSpawnShowcaseWidgetState();
}

class _IsolateSpawnShowcaseWidgetState
    extends State<IsolateSpawnShowcaseWidget> {
  Isolate? _isolate;
  late ReceivePort _incomingReceivePort;
  late SendPort _outgoingSendPort;

  @override
  void initState() {
    super.initState();

    _incomingReceivePort = ReceivePort();
    _incomingReceivePort.listen((message) {
      switch (message) {
        case SendPort():
          _outgoingSendPort = message;
          break;
        case int():
          showToast('Heavy task result: $message');
          break;
      }
    });

    Isolate.spawn(
      _secondIsolateEntryPoint,
      _incomingReceivePort.sendPort,
    ).then((isolate) {
      _isolate = isolate;
    });
  }

  @override
  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'Isolate.spawn',
      content: 'Stateful, longer-lived isolates',
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
    _outgoingSendPort.send('executeHeavyTask');
  }
}

Future<void> _secondIsolateEntryPoint(SendPort sendPort) async {
  var receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen(
    (dynamic message) async {
      if (message is! String) {
        return;
      }
      switch (message) {
        case 'executeHeavyTask':
          final result = _heavyTask(455553000);
          sendPort.send(result);
          break;
      }
    },
  );
}

int _heavyTask(int n) {
  int z = n;
  for (var i = 0; i < n; i++) {
    i % 2 == 0 ? z-- : z += 3;
  }
  return z + n;
}
