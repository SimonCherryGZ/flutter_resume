import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    Key? key,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 30.ss(),
        maxHeight: 160.ss(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.ss()),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLines: null,
        cursorColor: Theme.of(context).primaryColor,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.send,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        onChanged: widget.onChanged,
        onSubmitted: (text) {
          widget.onSubmitted?.call(text);
          _controller.clear();
          _focusNode.requestFocus();
        },
        onTapOutside: (_) {
          _focusNode.unfocus();
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.ss(),
            vertical: 10.ss(),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
