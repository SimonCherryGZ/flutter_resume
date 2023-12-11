import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/message/message.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final currentUser = appCubit.state.signedInUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息'),
      ),
      body: BlocProvider(
        create: (context) => MessageBloc(
          appCubit,
          context.read<ConversationRepository>(),
        )..add(FetchData()),
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            final conversations = state.conversations;
            return ListView.separated(
              padding: EdgeInsets.only(
                top: 10.ss(),
                bottom: 10.ss(),
              ),
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                final message = conversation.messages.last;
                return MessageItem(
                  message: message,
                  currentUser: currentUser,
                  onTap: () {
                    context.goNamed(
                      AppRouter.conversation,
                      extra: conversation,
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          },
        ),
      ),
    );
  }
}
