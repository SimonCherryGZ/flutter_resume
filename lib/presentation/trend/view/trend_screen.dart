import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/trend/trend.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TrendScreen extends StatefulWidget {
  const TrendScreen({super.key});

  @override
  State<TrendScreen> createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => TrendBloc(context.read<FeedRepository>()),
      child: PagingLoadWidget<TrendBloc, Feed>(
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
