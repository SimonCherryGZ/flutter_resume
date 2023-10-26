import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
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
    final l10n = L10nDelegate.l10n(context);
    final useKey = widget.useKey;
    return ShowcaseWidget(
      title: useKey
          ? l10n.swapStatefulWithKeyShowcaseTitle
          : l10n.swapStatefulWithoutKeyShowcaseTitle,
      content: useKey
          ? l10n.swapStatefulWithKeyShowcaseContent
          : l10n.swapStatefulWithoutKeyShowcaseContent,
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
              child: Text(l10n.swapStatefulShowcaseButtonText),
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
