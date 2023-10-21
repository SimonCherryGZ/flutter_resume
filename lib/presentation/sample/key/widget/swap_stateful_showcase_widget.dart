import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class SwapStatefulShowcaseWidget extends StatefulWidget {
  const SwapStatefulShowcaseWidget({
    super.key,
    required this.useKey,
  });

  final bool useKey;

  @override
  State<SwapStatefulShowcaseWidget> createState() =>
      _SwapStatefulShowcaseWidgetState();
}

class _SwapStatefulShowcaseWidgetState
    extends State<SwapStatefulShowcaseWidget> {
  late final List<Widget> _tiles;

  @override
  void initState() {
    super.initState();
    _tiles = [
      StatefulTile(
        color: Colors.red,
        index: 1,
        key: widget.useKey ? const ValueKey(1) : null,
      ),
      StatefulTile(
        color: Colors.blue,
        index: 2,
        key: widget.useKey ? const ValueKey(2) : null,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final useKey = widget.useKey;
    return ShowcaseWidget(
      title: 'StatefulWidget（${useKey ? '有' : '无'} Key）交换顺序',
      content:
          '序号来自 Widget 构造器传参\n颜色是 State 中的属性\n${useKey ? '序号和颜色都能交换' : '序号能交换，但颜色无法交换'}',
      builder: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _tiles,
            ),
            SizedBox(height: 30.ss()),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _tiles.insert(1, _tiles.removeAt(0));
                });
              },
              child: const Text('交换顺序'),
            ),
          ],
        );
      },
    );
  }
}

class StatefulTile extends StatefulWidget {
  const StatefulTile({
    super.key,
    required this.color,
    required this.index,
  });

  final Color color;
  final int index;

  @override
  State<StatefulTile> createState() => _StatefulTileState();
}

class _StatefulTileState extends State<StatefulTile> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.ss(),
      height: 80.ss(),
      color: _color,
      child: Center(
        child: Text(
          '${widget.index}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
