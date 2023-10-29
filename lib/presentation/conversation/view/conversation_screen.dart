import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/app/app.dart';
import 'package:flutter_resume/presentation/conversation/conversation.dart';
import 'package:flutter_resume/utils/utils.dart';

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
    return BlocProvider(
      create: (context) => ConversationBloc(
        widget.conversation.id,
        currentUser,
        otherUser,
        context.read<ConversationRepository>(),
      ),
      child: Builder(builder: (context) {
        final bloc = context.read<ConversationBloc>();
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            title: Text(otherUser.nickname),
          ),
          body: Column(
            children: [
              Expanded(
                child: BlocConsumer<ConversationBloc, ConversationState>(
                  listener: (context, state) {
                    if (state.messages.isNotEmpty) {
                      _scrollToBottom();
                    }
                  },
                  builder: (context, state) {
                    final messages = state.messages;
                    return Align(
                      alignment: Alignment.topLeft,
                      child: ListView.separated(
                        controller: _scrollController,
                        // 为了让列表一开始就"位于底部"，把列表上下颠倒
                        reverse: true,
                        // 列表上下颠倒后，如果 Item 不足一屏，Item 会居底
                        // 所以这里简单处理，不足 10 条数据时让列表高度变成有限高
                        // 然后被外层的 Align 给居顶
                        shrinkWrap: messages.length <= 10,
                        padding: EdgeInsets.symmetric(vertical: 20.ss()),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          // 因为列表上下颠倒，所以取数据也是从底到顶来取
                          final message = messages[messages.length - 1 - index];
                          final fromCurrentUser =
                              message.fromUser.id == currentUser.id;
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
                  },
                ),
              ),
              ChatBottomToolbar(
                onChanged: (text) {
                  _scrollToBottom();
                },
                onSubmitted: (text) {
                  bloc.add(AddMessage(text));
                  _scrollToBottom();
                },
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        );
      }),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!mounted || !_scrollController.hasClients) {
          return;
        }
        // 因消息列表上下颠倒（reverse: true），所以滚动到"底部"反而是要跳到 0 的位置
        _scrollController.jumpTo(0);
      },
    );
  }
}
