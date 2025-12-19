import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/common/common.dart';
import 'package:flutter_resume/presentation/sample/gesture/gesture.dart';
import 'package:flutter_resume/utils/utils.dart';

// https://github.com/flutter/flutter/issues/74733
class HitTestBehaviourShowcaseWidget extends StatefulWidget {
  const HitTestBehaviourShowcaseWidget({super.key});

  @override
  State<HitTestBehaviourShowcaseWidget> createState() =>
      _HitTestBehaviourShowcaseWidgetState();
}

class _HitTestBehaviourShowcaseWidgetState
    extends State<HitTestBehaviourShowcaseWidget> {
  bool _cyanBoxBeHit = false;
  bool _blueBoxBeHit = false;
  bool _purpleBoxBeHit = false;
  HitTestBehavior _blueBoxHitTestBehaviour = HitTestBehavior.deferToChild;

  @override
  Widget build(BuildContext context) {
    return ShowcaseWidget(
      title: 'HitTestBehaviour',
      content: 'Stack\n    - Cyan\n    - Blue\n        - Purple',
      builder: (context) {
        return Column(
          children: [
            _ColoredBoxStackWidget(
              blueBoxHitTestBehaviour: _blueBoxHitTestBehaviour,
              onNewHitStart: () {
                setState(() {
                  _cyanBoxBeHit = false;
                  _blueBoxBeHit = false;
                  _purpleBoxBeHit = false;
                });
              },
              onHitCyanBox: () {
                setState(() {
                  _cyanBoxBeHit = true;
                });
              },
              onHitBlueBox: () {
                setState(() {
                  _blueBoxBeHit = true;
                });
              },
              onHitPurpleBox: () {
                setState(() {
                  _purpleBoxBeHit = true;
                });
              },
            ),
            SizedBox(height: 10.ss()),
            _HitTestBehaviourRadioGroupWidget(
              hitTestBehavior: _blueBoxHitTestBehaviour,
              onChanged: (hitTestBehaviour) {
                if (hitTestBehaviour != null) {
                  setState(() {
                    _blueBoxHitTestBehaviour = hitTestBehaviour;
                  });
                }
              },
            ),
            SizedBox(height: 10.ss()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _HitTestResultWidget(
                  color: Colors.cyan,
                  label: 'Cyan',
                  beHit: _cyanBoxBeHit,
                ),
                _HitTestResultWidget(
                  color: Colors.blue,
                  label: 'Blue',
                  beHit: _blueBoxBeHit,
                ),
                _HitTestResultWidget(
                  color: Colors.purple,
                  label: 'Purple',
                  beHit: _purpleBoxBeHit,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ColoredBoxStackWidget extends StatelessWidget {
  const _ColoredBoxStackWidget({
    required this.blueBoxHitTestBehaviour,
    required this.onNewHitStart,
    required this.onHitCyanBox,
    required this.onHitBlueBox,
    required this.onHitPurpleBox,
  });

  final HitTestBehavior blueBoxHitTestBehaviour;
  final VoidCallback onNewHitStart;
  final VoidCallback onHitCyanBox;
  final VoidCallback onHitBlueBox;
  final VoidCallback onHitPurpleBox;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final canvasSize = screenSize * 0.8;
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        onNewHitStart();
      },
      child: SizedColoredBox(
        width: canvasSize.width,
        height: canvasSize.width,
        color: Colors.grey.shade200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Listener(
              behavior: HitTestBehavior.opaque,
              onPointerDown: (_) {
                onNewHitStart();
              },
              onPointerUp: (_) {
                onHitCyanBox();
              },
              child: _LabeledColoredBox(
                width: canvasSize.width * 0.75,
                height: canvasSize.width * 0.75,
                color: Colors.cyan,
                label: 'opaque',
              ),
            ),
            Listener(
              behavior: blueBoxHitTestBehaviour,
              onPointerDown: (_) {
                onNewHitStart();
              },
              onPointerUp: (_) {
                onHitBlueBox();
              },
              child: _LabeledColoredBox(
                width: canvasSize.width * 0.5,
                height: canvasSize.width * 0.5,
                color: Colors.blue,
                label: blueBoxHitTestBehaviour.name,
                child: Center(
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: (_) {
                      onNewHitStart();
                    },
                    onPointerUp: (_) {
                      onHitPurpleBox();
                    },
                    child: _LabeledColoredBox(
                      width: canvasSize.width * 0.25,
                      height: canvasSize.width * 0.25,
                      color: Colors.purple,
                      label: 'opaque',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledColoredBox extends StatelessWidget {
  const _LabeledColoredBox({
    required this.width,
    required this.height,
    required this.color,
    required this.label,
    this.child,
  });

  final double width;
  final double height;
  final Color color;
  final String label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedColoredBox(
          width: width,
          height: height,
          color: color,
          child: child,
        ),
        Positioned(
          left: 5.ss(),
          top: 2.ss(),
          child: Text(label, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class _HitTestBehaviourRadioGroupWidget extends StatelessWidget {
  const _HitTestBehaviourRadioGroupWidget({
    required this.hitTestBehavior,
    required this.onChanged,
  });

  final HitTestBehavior hitTestBehavior;
  final void Function(HitTestBehavior? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<HitTestBehavior>(
      groupValue: hitTestBehavior,
      onChanged: onChanged,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _HitTestBehaviourRadioWidget(
            hitTestBehavior: HitTestBehavior.deferToChild,
          ),
          _HitTestBehaviourRadioWidget(hitTestBehavior: HitTestBehavior.opaque),
          _HitTestBehaviourRadioWidget(
            hitTestBehavior: HitTestBehavior.translucent,
          ),
        ],
      ),
    );
  }
}

class _HitTestBehaviourRadioWidget extends StatelessWidget {
  const _HitTestBehaviourRadioWidget({required this.hitTestBehavior});

  final HitTestBehavior hitTestBehavior;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(hitTestBehavior.name, style: const TextStyle(color: Colors.black)),
        Radio<HitTestBehavior>(value: hitTestBehavior),
      ],
    );
  }
}

class _HitTestResultWidget extends StatelessWidget {
  const _HitTestResultWidget({
    required this.color,
    required this.label,
    required this.beHit,
  });

  final Color color;
  final String label;
  final bool beHit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.ss(),
      height: 40.ss(),
      color: beHit ? color : Colors.grey.shade300,
      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
