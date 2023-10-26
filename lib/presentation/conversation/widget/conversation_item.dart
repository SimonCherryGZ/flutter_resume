import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    required this.message,
    required this.fromCurrentUser,
  });

  final Message message;
  final bool fromCurrentUser;

  @override
  Widget build(BuildContext context) {
    return fromCurrentUser
        ? _RightConversationItem(message: message)
        : _LeftConversationItem(message: message);
  }
}

class _LeftConversationItem extends StatelessWidget {
  const _LeftConversationItem({
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 20.ss()),
        Column(
          children: [
            SizedBox(height: 5.ss()),
            CommonAvatarWidget(
              imageUrl: message.fromUser.avatar,
              size: 30.ss(),
            ),
          ],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(height: 5.ss()),
                  Icon(
                    Icons.arrow_left_rounded,
                    color: Colors.white,
                    size: 30.ss(),
                  ),
                ],
              ),
              Expanded(
                child: Transform.translate(
                  offset: Offset(-13.ss(), 0),
                  child: Container(
                    padding: EdgeInsets.all(10.ss()),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.ss()),
                    ),
                    child: Text(message.content),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 55.ss()),
      ],
    );
  }
}

class _RightConversationItem extends StatelessWidget {
  const _RightConversationItem({
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 55.ss()),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Transform.translate(
                  offset: Offset(13.ss(), 0),
                  child: Container(
                    padding: EdgeInsets.all(10.ss()),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.ss()),
                    ),
                    child: Text(message.content),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 5.ss()),
                  Icon(
                    Icons.arrow_right_rounded,
                    color: Colors.white,
                    size: 30.ss(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(height: 5.ss()),
            CommonAvatarWidget(
              imageUrl: message.fromUser.avatar,
              size: 30.ss(),
            ),
          ],
        ),
        SizedBox(width: 20.ss()),
      ],
    );
  }
}
