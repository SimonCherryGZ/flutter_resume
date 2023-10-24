import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';

class PostCommentItem extends StatelessWidget {
  const PostCommentItem({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 15.ss()),
        CommonAvatarWidget(
          imageUrl: comment.author.avatar,
          size: 30.ss(),
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
            ],
          ),
        ),
        SizedBox(width: 15.ss()),
      ],
    );
  }
}
