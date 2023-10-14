import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    this.title,
    this.content,
    this.negativeButtonText,
    this.positiveButtonText,
  });

  static Future<bool> show(
    BuildContext context, {
    String? title,
    String? content,
    String? negativeButtonText,
    String? positiveButtonText,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return CommonDialog(
          title: title,
          content: content,
          negativeButtonText: negativeButtonText,
          positiveButtonText: positiveButtonText,
        );
      },
    );
  }

  final String? title;
  final String? content;
  final String? negativeButtonText;
  final String? positiveButtonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      content: content != null ? Text(content!) : null,
      actions: [
        if (negativeButtonText != null) ...[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(negativeButtonText!),
          ),
        ],
        if (positiveButtonText != null) ...[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(positiveButtonText!),
          ),
        ],
      ],
    );
  }
}
