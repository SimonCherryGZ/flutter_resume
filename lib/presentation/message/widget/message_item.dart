import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.message,
    required this.currentUser,
    this.onTap,
  });

  final Message message;
  final User currentUser;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final otherUser = message.fromUser.id == currentUser.id
        ? message.toUser
        : message.fromUser;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: 60.ss(),
        child: Row(
          children: [
            SizedBox(width: 15.ss()),
            CommonAvatarWidget(
              imageUrl: otherUser.avatar,
              size: 40.ss(),
            ),
            SizedBox(width: 15.ss()),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        otherUser.nickname,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15.ss(),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('MM/dd/yyyy HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                message.timestamp)),
                        style: TextStyle(
                          fontSize: 11.ss(),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.ss()),
                  Text(
                    message.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 15.ss()),
          ],
        ),
      ),
    );
  }
}
