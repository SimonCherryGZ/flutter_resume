import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/conversation/conversation.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class ChatBottomToolbar extends StatelessWidget {
  const ChatBottomToolbar({
    super.key,
    this.onChanged,
    this.onSubmitted,
  });

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 5.ss(),
        vertical: 5.ss(),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showToast('占位，未实现');
            },
            icon: const Icon(Icons.keyboard_voice),
          ),
          Expanded(
            child: ChatTextField(
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          ),
          IconButton(
            onPressed: () {
              showToast('占位，未实现');
            },
            icon: const Icon(Icons.mood),
          ),
          IconButton(
            onPressed: () {
              showToast('占位，未实现');
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}
