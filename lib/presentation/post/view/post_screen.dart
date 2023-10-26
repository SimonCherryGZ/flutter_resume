import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/post/post.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({
    super.key,
    required this.feed,
    required this.heroTag,
  });

  final Feed feed;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageWidth = screenSize.width;
    final aspectRatio = feed.imageWidth * 1.0 / feed.imageHeight;
    final imageHeight = imageWidth / aspectRatio;
    final l10n = L10nDelegate.l10n(context);
    return BlocProvider(
      create: (context) =>
          PostBloc(context.read<PostRepository>())..add(FetchComments(feed)),
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: TextStyle(
            fontSize: 14.ss(),
          ),
          title: Row(
            children: [
              CommonAvatarWidget(
                imageUrl: feed.author.avatar,
                size: 30.ss(),
              ),
              SizedBox(width: 15.ss()),
              Text(
                feed.author.nickname,
                maxLines: 1,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              tooltip: 'Share',
              onPressed: () {
                // todo
                showToast('TODO: 开发中');
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: Hero(
                  tag: heroTag,
                  child: CommonFeedImageWidget(
                    imageUrl: feed.imageUrl,
                    imageWidth: imageWidth.toInt(),
                    imageHeight: imageHeight.toInt(),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 15.ss(),
                right: 15.ss(),
                top: 10.ss(),
                bottom: 5.ss(),
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  feed.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 17.ss(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 15.ss(),
                right: 15.ss(),
                top: 5.ss(),
                bottom: 10.ss(),
              ),
              sliver: SliverToBoxAdapter(
                child: Text(feed.content),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state.isFetching || state.comments.isEmpty) {
                  return const SliverToBoxAdapter();
                }
                return SliverPadding(
                  padding: EdgeInsets.only(
                    left: 15.ss(),
                    right: 15.ss(),
                    top: 10.ss(),
                    bottom: 20.ss(),
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      l10n.postCommentsInTotal(state.comments.length),
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state.isFetching) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state.comments.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chair,
                            size: 50.ss(),
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10.ss()),
                          Text(
                            l10n.postNoReplies,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SliverList.separated(
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    return PostCommentItem(
                      index: index,
                      comment: comment,
                      avatarSize: 30.ss(),
                      showReply: true,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 30.ss(),
                      child: Divider(indent: 55.ss()),
                    );
                  },
                );
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 30.ss()),
            ),
          ],
        ),
      ),
    );
  }
}
