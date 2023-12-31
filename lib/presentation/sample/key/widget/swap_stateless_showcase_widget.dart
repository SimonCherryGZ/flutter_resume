import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class SwapStatelessShowcaseWidget extends StatefulWidget {
  const SwapStatelessShowcaseWidget({super.key});

  @override
  State<SwapStatelessShowcaseWidget> createState() =>
      _SwapStatelessShowcaseWidgetState();
}

class _SwapStatelessShowcaseWidgetState
    extends State<SwapStatelessShowcaseWidget> {
  final _tiles = [
    const StatelessTile(
      color: Colors.red,
      index: 1,
    ),
    const StatelessTile(
      color: Colors.blue,
      index: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    return ShowcaseWidget(
      title: l10n.swapStatelessShowcaseTitle,
      content: l10n.swapStatelessShowcaseContent,
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
              child: Text(l10n.swapStatelessShowcaseButtonText),
            ),
          ],
        );
      },
    );
  }
}

class StatelessTile extends StatelessWidget {
  const StatelessTile({
    super.key,
    required this.color,
    required this.index,
  });

  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.ss(),
      height: 80.ss(),
      color: color,
      child: Center(
        child: Text(
          '$index',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
