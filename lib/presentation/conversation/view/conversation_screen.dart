import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/conversation/conversation.dart';
import 'package:flutter_resume/utils/utils.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({
    super.key,
    required this.conversation,
  });

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final currentUser = appCubit.state.signedInUser!;
    final firstMessage = conversation.messages.first;
    final otherUser = firstMessage.fromUser.id == currentUser.id
        ? firstMessage.toUser
        : firstMessage.fromUser;
    final messages = conversation.messages;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(otherUser.nickname),
      ),
      body: ListView.separated(
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
    );
  }
}
