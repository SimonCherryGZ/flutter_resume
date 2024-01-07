import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:oktoast/oktoast.dart';

class AppBarBehaviorOptionsWidget extends StatelessWidget {
  const AppBarBehaviorOptionsWidget({
    super.key,
    required this.floating,
    required this.pinned,
    required this.snap,
    this.onChanged,
  });

  final bool floating;
  final bool pinned;
  final bool snap;
  final void Function(bool floating, bool pinned, bool snap)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SwitchWidget(
          label: 'Floating',
          value: floating,
          onChanged: (floating) {
            if (snap == true && floating != true) {
              showToast('Snapping only applies when the app bar is floating');
            }
            onChanged?.call(floating, pinned, floating == false ? false : snap);
          },
        ),
        SwitchWidget(
          label: 'Pinned',
          value: pinned,
          onChanged: (pinned) {
            onChanged?.call(floating, pinned, snap);
          },
        ),
        SwitchWidget(
          label: 'Snap',
          value: snap,
          onChanged: (snap) {
            if (snap == true && floating != true) {
              showToast('Snapping only applies when the app bar is floating');
              return;
            }
            onChanged?.call(floating, pinned, snap);
          },
        ),
      ],
    );
  }
}
