import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/presentation/discover/discover.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverBloc(context.read<FeedRepository>()),
      child: PagingLoadWidget<DiscoverBloc, Feed>(
        builder: (context, data) {
          return SliverList.separated(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final feed = data[index];
              return DiscoverItem(feed: feed);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
