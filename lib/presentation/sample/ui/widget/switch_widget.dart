import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
  });

  final String label;
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30.ss(),
          padding: EdgeInsets.symmetric(horizontal: 10.ss()),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.ss()),
            color: Colors.black.withOpacity(0.3),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: (value) {
            onChanged?.call(value);
          },
        ),
      ],
    );
  }
}
