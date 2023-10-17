import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/discover/discover.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DiscoverBloc(context.read<FeedRepository>())..add(FetchData()),
      child: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          final feeds = state.feeds;
          final bloc = context.read<DiscoverBloc>();
          return EasyRefresh(
            onRefresh: () {
              bloc.add(FetchData(isRefresh: true));
            },
            onLoad: () {
              bloc.add(FetchData());
            },
            child: ListView.separated(
              itemCount: feeds.length,
              itemBuilder: (context, index) {
                final feed = feeds[index];
                return DiscoverItem(feed: feed);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          );
        },
      ),
    );
  }
}
