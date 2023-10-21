import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/trend/trend.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TrendScreen extends StatelessWidget {
  const TrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
}
