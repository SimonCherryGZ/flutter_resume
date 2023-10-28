import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/conversation/conversation.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    super.key,
    required this.conversation,
  });

  final Conversation conversation;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with WidgetsBindingObserver {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    _scrollToBottom();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final currentUser = appCubit.state.signedInUser!;
    final firstMessage = widget.conversation.messages.first;
    final otherUser = firstMessage.fromUser.id == currentUser.id
        ? firstMessage.toUser
        : firstMessage.fromUser;
    final messages = widget.conversation.messages;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(otherUser.nickname),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 20.ss()),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final fromCurrentUser = message.fromUser.id == currentUser.id;
                return ConversationItem(
                  message: message,
                  fromCurrentUser: fromCurrentUser,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20.ss());
              },
            ),
          ),
          ChatBottomToolbar(
            onChanged: (text) {
              _scrollToBottom();
            },
            onSubmitted: (text) {
              // todo
              showToast(text);
            },
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!mounted || !_scrollController.hasClients) {
          return;
        }
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      },
    );
  }
}
