import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';

class PostCommentItem extends StatefulWidget {
  const PostCommentItem({
    super.key,
    required this.comment,
    required this.avatarSize,
    this.showReply = false,
  });

  final Comment comment;
  final double avatarSize;
  final bool showReply;

  @override
  State<PostCommentItem> createState() => _PostCommentItemState();
}

class _PostCommentItemState extends State<PostCommentItem> {
  int _totalReplyCount = 0;
  int _showReplyCount = 0;
  int _remainReplyCount = 0;

  @override
  void initState() {
    super.initState();
    _totalReplyCount = widget.comment.replies.length;
    _showReplyCount = min(3, _totalReplyCount);
    _remainReplyCount = max(0, _totalReplyCount - _showReplyCount);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 15.ss()),
        CommonAvatarWidget(
          imageUrl: widget.comment.author.avatar,
          size: widget.avatarSize,
        ),
        SizedBox(width: 10.ss()),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.comment.author.nickname,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12.ss(),
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.ss()),
              Text(
                widget.comment.content,
              ),
              if (widget.showReply && _showReplyCount > 0)
                ...(_showReplyCount < _totalReplyCount
                        ? widget.comment.replies.sublist(0, _showReplyCount)
                        : widget.comment.replies)
                    .map((reply) {
                  return Padding(
                    padding: EdgeInsets.only(top: 15.ss()),
                    child: PostCommentItem(
                      comment: reply,
                      avatarSize: 20.ss(),
                    ),
                  );
                }).toList(),
              if (widget.showReply && _remainReplyCount > 0) ...[
                Padding(
                  padding: EdgeInsets.only(
                    left: 40.ss(),
                    top: 10.ss(),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _showReplyCount += 3;
                        _showReplyCount =
                            min(_totalReplyCount, _showReplyCount);
                        _remainReplyCount = _totalReplyCount - _showReplyCount;
                      });
                    },
                    child: const Text(
                      '展开更多回复',
                      style: TextStyle(
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
