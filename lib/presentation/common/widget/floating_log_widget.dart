import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';

class FloatingLogController {
  void addLog(String log) {
    _cachedLogs.add(log);
    addLogCallback?.call(log);
  }

  Function(String)? addLogCallback;

  final _cachedLogs = <String>[];

  List<String> popCachedLogs() {
    final logs = List<String>.from(_cachedLogs);
    _cachedLogs.clear();
    return logs;
  }

  void dispose() {
    addLogCallback = null;
    _cachedLogs.clear();
  }
}

class FloatingLogWidget extends StatefulWidget {
  static void show({
    required BuildContext context,
    FloatingLogController? controller,
    String? tag,
  }) {
    DraggableStickyOverlayWidget.show(
      tag: tag,
      context: context,
      view: FloatingLogWidget(
        key: GlobalKey(),
        controller: controller,
      ),
      viewSize: Size(
        MediaQuery.sizeOf(context).width * 0.8,
        300.ss(),
      ),
    );
  }

  const FloatingLogWidget({
    Key? key,
    this.controller,
    this.onAddLog,
  }) : super(key: key);

  final FloatingLogController? controller;
  final Function(String)? onAddLog;

  @override
  State<FloatingLogWidget> createState() => _FloatingLogWidgetState();
}

class _FloatingLogWidgetState extends State<FloatingLogWidget> {
  final List<String> _logList = [];
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    widget.controller?.addLogCallback = (log) {
      if (!mounted) {
        return;
      }
      setState(() {
        _logList.add(log);
        _scrollToBottom();
      });
    };

    final logs = widget.controller?.popCachedLogs();
    if (logs != null && logs.isNotEmpty) {
      setState(() {
        _logList.addAll(logs);
        _scrollToBottom();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width * 0.8,
      height: 300.ss(),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: 10.ss(),
                vertical: 10.ss(),
              ),
              itemCount: _logList.length,
              itemBuilder: (context, index) {
                final log = _logList[index];
                return Text(
                  log,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          SizedBox(height: 10.ss()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _logList.clear();
                  });
                },
                child: const Text('Clear'),
              ),
              ElevatedButton(
                onPressed: () {
                  DraggableStickyOverlayWidget.remove();
                },
                child: const Text('Close'),
              ),
            ],
          ),
          SizedBox(height: 10.ss()),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.fastOutSlowIn,
      );
    });
  }
}
