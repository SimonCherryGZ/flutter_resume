import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/domain/entity/feed.dart';
import 'package:flutter_resume/presentation/trend/widget/trend_item.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class SampleWaterfallFlowScreen extends StatelessWidget {
  const SampleWaterfallFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['A', 'B'];
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _AppBarWidget(
                tabs: tabs,
                innerBoxIsScrolled: innerBoxIsScrolled,
              ),
            ];
          },
          body: _BodyWidget(tabs: tabs),
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatefulWidget {
  const _AppBarWidget({
    required this.tabs,
    required this.innerBoxIsScrolled,
  });

  final List<String> tabs;
  final bool innerBoxIsScrolled;

  @override
  State<_AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<_AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('WaterfallFlow'),
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 250.ss(),
      forceElevated: widget.innerBoxIsScrolled,
      flexibleSpace: _HeaderBackgroundWidget(),
      bottom: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        tabs: widget.tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}

class _HeaderBackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAOEcdM.img',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    required this.tabs,
  });

  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: tabs.map((e) {
        return const SampleWaterfallSubScreen();
      }).toList(),
    );
  }
}

class SampleWaterfallSubScreen extends StatefulWidget {
  const SampleWaterfallSubScreen({super.key});

  @override
  State<SampleWaterfallSubScreen> createState() =>
      _SampleWaterfallSubScreenState();
}

class _SampleWaterfallSubScreenState extends State<SampleWaterfallSubScreen>
    with AutomaticKeepAliveClientMixin {
  SampleWaterfallFlowRepository listSourceRepository =
      SampleWaterfallFlowRepository();
  DateTime? dateTimeNow;

  @override
  void dispose() {
    super.dispose();
    listSourceRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshNotification(
      pullBackOnRefresh: true,
      maxDragOffset: 90,
      armedDragUpCancel: false,
      onRefresh: () {
        return listSourceRepository.refresh();
      },
      child: LoadingMoreCustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: PullToRefreshContainer(
                (PullToRefreshScrollNotificationInfo? info) {
              return _PullToRefreshHeader(info);
            }),
          ),
          LoadingMoreSliverList<Feed>(
            SliverListConfig<Feed>(
              extendedListDelegate:
                  const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, item, index) {
                return TrendItem(feed: item);
              },
              sourceList: listSourceRepository,
              padding: const EdgeInsets.all(5.0),
              lastChildLayoutType: LastChildLayoutType.foot,
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SampleWaterfallFlowRepository extends LoadingMoreBase<Feed> {
  final Faker _faker;

  SampleWaterfallFlowRepository() : _faker = Faker(1);

  static const int _maxCount = 100;
  static const int _pageSize = 20;

  final List<Feed> _feeds = [];

  int _pageIndex = 0;
  bool _hasMore = true;
  bool forceRefresh = false;

  @override
  bool get hasMore => (_hasMore && length < _maxCount) || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    _pageIndex = 0;
    forceRefresh = !notifyStateChanged;
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    if (_feeds.isEmpty) {
      for (int i = 0; i < _maxCount; i++) {
        int index = i + 1;
        final url = _faker.imageUrl();
        final start = url.lastIndexOf('_') + 1;
        final end = url.lastIndexOf('.');
        final substring = url.substring(start, end);
        final splits = substring.split('x');
        final width = int.parse(splits[0]);
        final height = int.parse(splits[1]);
        final feed = Feed(
          id: '$index',
          title: _faker.title(),
          imageUrl: url,
          imageWidth: width,
          imageHeight: height,
          author: _faker.user(),
          content: _faker.content(),
        );
        _feeds.add(feed);
      }
    }

    if (_pageIndex == 0) {
      clear();
    }

    _pageIndex++;

    int start = (_pageIndex - 1) * _pageSize;
    if (start >= _maxCount) {
      _hasMore = false;
      return false;
    }

    int end = min(start + _pageSize, _maxCount);
    final subList = _feeds.sublist(start, end);
    for (final feed in subList) {
      if (!contains(feed) && hasMore) {
        add(feed);
      }
    }
    return true;
  }
}

class _PullToRefreshHeader extends StatelessWidget {
  const _PullToRefreshHeader(this.info);

  final PullToRefreshScrollNotificationInfo? info;

  @override
  Widget build(BuildContext context) {
    if (info == null) {
      return Container();
    }
    final double dragOffset = info?.dragOffset ?? 0.0;
    return Container(
      height: dragOffset,
      width: double.maxFinite,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 10.ss()),
      child: Icon(
        Icons.flutter_dash,
        size: (dragOffset - 10.ss()).clamp(
          0.0,
          40.ss(),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
