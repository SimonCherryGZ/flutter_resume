import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/profile/profile.dart';
import 'package:flutter_resume/presentation/trend/trend.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) =>
          UserFeedBloc(context.read<FeedRepository>())..add(FetchData()),
      child: PagingLoadWidget<UserFeedBloc, Feed>(
        headerBuilder: (context) {
          return SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          );
        },
        builder: (context, data) {
          return SliverMasonryGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4.ss(),
            crossAxisSpacing: 4.ss(),
            childCount: data.length,
            itemBuilder: (context, index) {
              final feed = data[index];
              return TrendItem(
                feed: feed,
                heroTagPrefix: 'user_feed',
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
