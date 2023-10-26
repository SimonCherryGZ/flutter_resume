import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/post/post.dart';
import 'package:flutter_resume/utils/utils.dart';

class PostCommentItem extends StatelessWidget {
  const PostCommentItem({
    super.key,
    required this.index,
    required this.comment,
    required this.avatarSize,
    this.showReply = false,
  });

  final int index;
  final Comment comment;
  final double avatarSize;
  final bool showReply;

  @override
  Widget build(BuildContext context) {
    int totalReplyCount = comment.replies.length;
    int showReplyCount = min(max(3, comment.showReplyCount), totalReplyCount);
    int remainReplyCount = max(0, totalReplyCount - showReplyCount);
    final l10n = L10nDelegate.l10n(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 15.ss()),
        CommonAvatarWidget(
          imageUrl: comment.author.avatar,
          size: avatarSize,
        ),
        SizedBox(width: 10.ss()),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.author.nickname,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12.ss(),
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.ss()),
              Text(
                comment.content,
              ),
              if (showReply && showReplyCount > 0)
                ...(showReplyCount < totalReplyCount
                        ? comment.replies.sublist(0, showReplyCount)
                        : comment.replies)
                    .map((reply) {
                  return Padding(
                    padding: EdgeInsets.only(top: 15.ss()),
                    child: PostCommentItem(
                      index: -1,
                      comment: reply,
                      avatarSize: 20.ss(),
                    ),
                  );
                }).toList(),
              if (showReply && remainReplyCount > 0) ...[
                Padding(
                  padding: EdgeInsets.only(
                    left: 40.ss(),
                    top: 10.ss(),
                  ),
                  child: TextButton(
                    onPressed: () {
                      context.read<PostBloc>().add(ExpandReply(index));
                    },
                    child: Text(
                      l10n.postExpandMoreReplies,
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: 15.ss()),
      ],
    );
  }
}
